json.array!(@project_log_entries) do |project_log_entry|
  json.extract! project_log_entry, :id, :project_id, :task_id, :user_id, :activity_type
  json.url project_log_entry_url(project_log_entry, format: :json)
end
