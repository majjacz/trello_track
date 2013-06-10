module ApplicationHelper

  def today_date (date = Time.zone.now)
    {year: date.year, month: date.month, day: date.day}
  end

  def format_with_day(time, start_time, end_time)
    end_time ||= start_time
    start_time.day == (end_time - 1.seconds).day ? time.strftime("%H:%M") : time.strftime("%H:%M (%a)")
  end

end
