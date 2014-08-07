class User < ActiveRecord::Base
  include Initials

  belongs_to :organisation, touch: true
  has_many :comments, -> { order 'created_at DESC' }
  has_many :email_addresses, -> { order 'address' }, dependent: :delete_all
  has_many :numbers, dependent: :delete_all
  has_many :timesheet_entries, -> { order 'started_at DESC' }, dependent: :nullify
  has_many :issues, -> { order 'completed, priority' }, foreign_key: 'assignee_id'
  has_many :organisation_watchers

  # unencrypted password
  attr_accessor :password
    
  # validation
  validates_length_of     :email, within: 3..100
  validates_uniqueness_of :email, case_sensitive: false, message: 'has already been taken. If you have forgotten your password, contact us at ' + EMAIL + ' to request a new one.'
  
  validates_presence_of   :name
  validates_length_of     :password, within: 4..40,
                                     if: :password_required?
  validates_confirmation_of :password, if: :password_required?

  validates_presence_of :organisation
  
  # callbacks
  before_save :encrypt_password

  # encrypts given password using salt
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{pass}--")
  end
  
  # authenticate by email/password
  def self.authenticate(email, pass)
    user = find_by_email(email)
    user && user.authenticated?(pass) ? user : nil
  end

  def to_s
    name
  end

  # does the given password match the stored encrypted password
  def authenticated?(pass)
    encrypted_password == User.encrypt(pass, salt)
  end
  
  def self.generate_forgot_password_token
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    (0...8).map{ charset.to_a[rand(charset.size)] }.join
  end

  # Timesheet hours logged by this user on a single given day at days_ago.
  def hours_logged(days_ago = 0)
    TimesheetEntry.hours_logged_between_days(days_ago, days_ago) { |q| q.where(user_id: id) }
  end

  def hours_logged_to_date(days_ago)
    TimesheetEntry.hours_logged_between_days(0, days_ago) do |q|
      q.where(user_id: id)
    end.ceil
  end


  protected
  
  # before save - create salt, encrypt password
  def encrypt_password
    return if password.blank?
    if salt.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now}--#{email}--")
    end
    self.encrypted_password = User.encrypt(password, salt)
  end
  
  # no encrypted password yet OR password attribute is set
  def password_required?
    encrypted_password.blank? || !password.blank?
  end 

  def self.staff
    where(staff: true).order('name ASC')
  end
end
