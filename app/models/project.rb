class Project < ActiveRecord::Base

  def name
    read_attribute(:name) || board_id
  end

end
