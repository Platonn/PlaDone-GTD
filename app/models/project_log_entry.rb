class ProjectLogEntry < ActiveRecord::Base
  belongs_to  :project
  belongs_to  :user
  belongs_to  :task

  enum activity_type: [:project_created,
                       :project_deleted,
                       :project_closed,
                       :project_reopened,
                       :project_name_changed,
                       :project_category_changed,
                       :project_notes_changed,
                       :project_deadline_changed
                      ]
end
