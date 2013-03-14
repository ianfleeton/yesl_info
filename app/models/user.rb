class User < ActiveRecord::Base
  belongs_to :organisation, touch: true
  has_many :email_addresses, :dependent => :delete_all
  has_many :numbers, :dependent => :delete_all
  has_many :timesheet_entries, dependent: :nullify, order: 'started_at DESC'
  has_many :to_dos, foreign_key: 'assignee_id', order: 'completed, priority'

  # unencrypted password
  attr_accessor :password
    
  # validation
  validates_length_of     :email, :within => 3..100
  validates_uniqueness_of :email, :case_sensitive => false, :message => 'has already been taken. If you have forgotten your password, contact us at ' + EMAIL + ' to request a new one.'
  
  validates_presence_of   :name
  validates_length_of     :password, :within => 4..40,
                                     :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  
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
  
  # does the given password match the stored encrypted password
  def authenticated?(pass)
    encrypted_password == User.encrypt(pass, salt)
  end
  
  def self.generate_forgot_password_token
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    (0...8).map{ charset.to_a[rand(charset.size)] }.join
  end

  def hours_logged(days_ago = 0)
    the_time = Time.now - days_ago.days
    beginning_of_the_day = the_time.strftime('%Y-%m-%d 00:00:00')
    end_of_the_day = the_time.strftime('%Y-%m-%d 23:59:59')
    TimesheetEntry.where(['user_id = ? AND started_at >= ? AND started_at <= ?', id, beginning_of_the_day, end_of_the_day]).sum('minutes') / 60.0
  end

  def hours_logged_to_date(days_ago)
    total = 0;
    (0..days_ago).each do |days|
      total += hours_logged(days)
    end
    return total.ceil
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
    all conditions: {staff: true}, order: 'name ASC'
  end
end
