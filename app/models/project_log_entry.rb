class ProjectLogEntry < ActiveRecord::Base
  enum activity_type: [:project_created,
                      :project_deleted,
                      :project_closed,
                      :project_reopened,
                      :project_name_changed,
                      :project_category_changed
                     ]
end
