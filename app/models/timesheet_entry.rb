class TimesheetEntry < ActiveRecord::Base
  #validates_presence_of :description, :user_id, :organisation_id
  belongs_to :user, touch: true
  belongs_to :organisation, touch: true

  def self.recently_worked_with
    # TODO: there should be an attribute of organisations instead of this hacky list of IDs to exclude
    excluded_organisations = '9, 539, 562, 679, 680, 689'
    minimum_minutes = 240
    active_since_months = 12
    select('organisation_id, SUM(minutes)/60 AS hours, SUM(CASE WHEN chargeable = 1 THEN invoice_value ELSE 0 END) / (SUM(minutes) / 60) AS hourly, organisations.name')
      .joins('LEFT JOIN organisations ON organisations.id = organisation_id')
      .where("started_at >= DATE_SUB(NOW(), INTERVAL ? MONTH) AND organisation_id NOT IN (#{excluded_organisations})", active_since_months)
      .group('organisation_id')
      .having('SUM(minutes) >= ?', minimum_minutes)
      .order('hourly DESC')
  end
end
