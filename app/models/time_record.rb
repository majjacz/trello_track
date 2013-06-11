class TimeRecord < ActiveRecord::Base

  default_scope { order('start_time ASC') }

  belongs_to :task

  def total_time_capped_by(start_time, end_time)
    if end_time
      end_time_capped_by(end_time) - start_time_capped_by(start_time)
    end
  end

  def end_time_capped_by(time)
    if end_time
      if end_time >= time
        return time
      else
        return end_time
      end
    end
  end

  def start_time_capped_by(time)
    if start_time <= time
      return time
    else
      return start_time
    end
  end

end
