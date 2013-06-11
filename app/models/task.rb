class Task < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  has_many :time_records

  scope :between, lambda { |start_time, end_time| includes(:time_records).where("
           (time_records.start_time >= :start_time AND time_records.start_time <= :end_time) OR
           (time_records.end_time <= :end_time AND time_records.end_time >= :start_time)",
           {:end_time => end_time, :start_time => start_time})
         }

  def self.default_scope
    includes(:time_records).order('time_records.start_time ASC')
  end

  def self.start(user, name, board_id, card_id)
    unless user.tasks.last.end_time.nil?
      t = Task.new
      t.user = user
      t.name = name
      t.card_id = card_id
      t.project = Project.find_or_create_by_board_id(board_id)

      r = TimeRecord.new
      r.task = t
      r.start_time = Time.now

      return true if t.save and r.save
    end
  end

  def stop
    if r = time_records.last
      r.end_time = Time.now
      return true if r.save
    end
  end

  def continue
    if user.task.last == self
      r = TimeRecord.new
      r.task = t
      r.start_time = Time.now
      return true if r.save
    else
      last_task = user.task.last
      Task.start(user, last_task.name, last_task.board_id, last_task.card_id)
    end
  end

  def start_time
    time_records.first.start_time
  end

  def end_time
    time_records.last.end_time
  end

  def total_time_capped_by(start_time, end_time)
    if end_time
      total_seconds = time_records.sum do |t|
        t.total_time_capped_by(start_time, end_time) || 0
      end
      return total_seconds
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
