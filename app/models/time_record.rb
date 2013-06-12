class TimeRecord < ActiveRecord::Base

  default_scope { order('start_time ASC') }

  belongs_to :task

  def total_time_capped_by(start_time, end_time)
    unless self.end_time.nil?
      end_time_capped_by(end_time) - start_time_capped_by(start_time)
    end
  end

  def end_time_capped_by(time)
    unless self.end_time.nil?
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

  def start_time
    read_attribute(:start_time).in_time_zone
  end

  def end_time
    read_attribute(:end_time).in_time_zone if read_attribute(:end_time)
  end

end
