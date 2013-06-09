class TimeRecord < ActiveRecord::Base
  belongs_to :user

  scope :between, lambda { |start_time, end_time| where("
           (start_time >= :start_time AND start_time <= :end_time) OR
           (end_time <= :end_time AND end_time >= :start_time)",
           {:end_time => end_time, :start_time => start_time})
         }

  def human_total_time_capped_by(start_time, end_time)
    Time.diff(end_time_capped_by(end_time), start_time_capped_by(start_time) + paused_for.seconds)
  end

  def total_time_capped_by(start_time, end_time)
    end_time_capped_by(end_time) - start_time_capped_by(start_time) - paused_for
  end

  def end_time_capped_by(time)
    if end_time >= time
      return time
    else
      return end_time
    end
  end

  def start_time_capped_by(time)
    if start_time <= time
      return time
    else
      return start_time
    end
  end

  def over(time)
    start_time <= time and end_time >= time
  end

end
