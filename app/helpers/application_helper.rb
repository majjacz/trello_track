module ApplicationHelper

  def today_date (date = Time.zone.now)
    {year: date.year, month: date.month, day: date.day}
  end

end
