json.array!(@tasks) do |task|
  json.extract! task, :project_id, :name, :card_id
  json.url task_url(task, format: :json)
end
