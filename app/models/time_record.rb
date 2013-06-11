class TimeRecord < ActiveRecord::Base

  validates :paused_for, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }

  belongs_to :user

  scope :between, lambda { |start_time, end_time| where("
           (start_time >= :start_time AND start_time <= :end_time) OR
           (end_time <= :end_time AND end_time >= :start_time)",
           {:end_time => end_time, :start_time => start_time})
         }

  scope :in_progress, lambda {where('end_time IS NULL OR paused = 1').joins(:user)}

  def self.start(user, name, board_id, card_id)
    if TimeRecord.in_progress.empty?
      r = TimeRecord.new
      r.user_id = user.id
      r.name = name
      r.trello_board_id = board_id
      r.trello_card_id = card_id
      r.start_time = Time.now
      r.save
    end
  end

  def stop
    self.end_time = Time.now
    save!
  end

  def pause
    self.end_time = Time.now
    self.paused = true
    save!
  end

  def continue_from_pause
    if self.paused
      self.paused_for = self.paused_for + Time.now - self.end_time
    end
    self.end_time = nil
    self.paused = false
    save!
  end

  def human_total_time_capped_by(start_time, end_time)
    if self.end_time
      Time.diff(end_time_capped_by(end_time), start_time_capped_by(start_time) + paused_for.seconds)
    end
  end

  def total_time_capped_by(start_time, end_time)
    if self.end_time
      end_time_capped_by(end_time) - start_time_capped_by(start_time) - paused_for
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

  def over(time)
    if end_time
      start_time <= time and end_time >= time
    end
  end

end
