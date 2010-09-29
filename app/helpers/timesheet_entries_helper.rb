module TimesheetEntriesHelper
  def amount_invoiced_by(who, days, chargeable=2)
    if(chargeable == 1 || chargeable == 0)
      chargeable = 1 - chargeable
    end
    conditions = ["user_id=? AND started_at>=DATE_SUB(NOW(), INTERVAL ? DAY) AND chargeable<>?",
      who.id, days, chargeable]
    TimesheetEntry.calculate(:sum, :invoice_value, :conditions => conditions)
  end
end
