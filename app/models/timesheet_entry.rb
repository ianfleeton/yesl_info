class TimesheetEntry < ActiveRecord::Base
  #validates_presence_of :description, :user_id, :organisation_id
  belongs_to :user, touch: true
  belongs_to :organisation, touch: true

  before_validation :set_non_nil_values

  def self.recently_worked_with
    minimum_minutes = 240
    active_since_months = 12
    select('organisation_id, SUM(minutes)/60 AS hours, SUM(CASE WHEN chargeable = 1 THEN invoice_value ELSE 0 END) / (SUM(minutes) / 60) AS hourly, organisations.name')
      .joins('LEFT JOIN organisations ON organisations.id = organisation_id')
      .where("started_at >= DATE_SUB(NOW(), INTERVAL ? MONTH)", active_since_months)
      .group('organisation_id')
      .having('SUM(minutes) >= ?', minimum_minutes)
      .order('hourly DESC')
  end

  def self.hours_logged_between_days(min_days_ago, max_days_ago)
    start_time = Time.now - max_days_ago.days
    end_time   = Time.now - min_days_ago.days
    beginning_of_the_day = start_time.strftime('%Y-%m-%d 00:00:00')
    end_of_the_day       = end_time.strftime(  '%Y-%m-%d 23:59:59')
    query = where(['started_at >= ? AND started_at <= ?', beginning_of_the_day, end_of_the_day])
    query = yield query if block_given?
    query.sum('minutes') / 60.0
  end

  def set_non_nil_values
    self.invoice_value ||= 0
    self.minutes ||= 0
  end
end
