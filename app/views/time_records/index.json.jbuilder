json.array!(@time_records) do |time_record|
  json.extract! time_record, :user_id, :trello_board_id, :start_time, :end_time, :pause_time
  json.url time_record_url(time_record, format: :json)
end
