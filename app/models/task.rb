class Task < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  has_many :time_records
  has_one :not_finished, :class_name => 'TimeRecord', conditions: {:end_time => nil}
  accepts_nested_attributes_for :time_records

  scope :between, lambda { |start_time, end_time| where("
           time_records.start_time < :end_time AND
           (time_records.end_time > :start_time OR
           (time_records.end_time IS NULL AND time_records.start_time > :start_time))",
           {:end_time => end_time, :start_time => start_time})
         }

  scope :users, lambda { |users| where(:user_id => users)}
  scope :projects, lambda { |projects| where(:project_id => projects) }

  def self.default_scope
    includes(:time_records).order('time_records.start_time ASC')
  end

  def self.start(user, name, board_id, card_id)
    if user.unfinished_task.nil?
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

  def update_time_records(name, start_time, seconds)
    transaction do
      self.name = name
      time_records.destroy_all
      r = TimeRecord.new()
      r.task = self
      r.start_time = start_time.in_time_zone('UTC')
      r.end_time = r.start_time + seconds
      return true if self.save and r.save
    end
  end

  def stop
    if r = time_records.last
      r.end_time = Time.now
      return true if r.save
    end
  end

  def continue
    last_task = user.tasks.last
    if last_task == self
      r = TimeRecord.new
      r.task = self
      r.start_time = Time.now
      return true if r.save
    else
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
    if self.end_time
      total_seconds = time_records.to_a.sum do |t|
        t.total_time_capped_by(start_time, end_time) || 0
      end
      return total_seconds
    end
  end

  def total_time
    if self.end_time
      total_seconds = time_records.sum do |t|
        t.total_time || 0
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
      start_time < time and end_time > time
    end
  end

end
