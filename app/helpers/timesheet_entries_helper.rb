module TimesheetEntriesHelper
  def amount_invoiced_by(who, days, chargeable=2)
    if who.respond_to?(:each)
      return who.inject(0) {|sum, person| sum + amount_invoiced_by(person, days, chargeable)}
    end

    if(chargeable == 1 || chargeable == 0)
      chargeable = 1 - chargeable
    end
    conditions = ["user_id=? AND started_at>=DATE_SUB(NOW(), INTERVAL ? DAY) AND chargeable<>?",
      who.id, days, chargeable]
    TimesheetEntry.calculate(:sum, :invoice_value, :conditions => conditions)
  end

  def hours_logged_this_week_by(who)
    total = 0
    str = ''
    (0..6).each do |days_ago|
      logged = who.hours_logged(days_ago)
      total += logged
      str += '%.1f' % logged
      if(days_ago < 6)
        str += ' + '
      end
    end
    str + ' = ' + '%.1f' % total
  end
end
