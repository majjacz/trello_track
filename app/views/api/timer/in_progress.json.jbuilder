if @record
  json.extract! @record, :name, :trello_board_id, :trello_card_id, :start_time, :end_time, :paused
end
