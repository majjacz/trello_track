module ApplicationHelper

  def today_date (date = Time.zone.now)
    {year: date.year, month: date.month, day: date.day}
  end

  def format_with_day(time, start_time, end_time)
    end_time ||= start_time
    start_time.day == (end_time - 1.seconds).day ? time.strftime("%H:%M") : time.strftime("%H:%M (%a)")
  end

  def seconds_to_human_time(seconds)
    "%02d:%02d:%02d" % [(seconds / 3600).to_i, ((seconds % 3600) / 60).to_i, (seconds % 60).to_i]
  end

end
