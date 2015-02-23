class ProjectLogService
  def get_history(project_id, limit)
    results = ProjectLogEntry
      .where(["project_id = :project_id", { project_id: project_id }])
      .order(created_at: :desc)

    if limit.nil?
      results
    else
      results.limit(limit)
    end
  end

  def project_updated(project_id, user_id, previous_attrs, new_attrs)
    unless equal_or_both_blank?(previous_attrs[:name], new_attrs[:name])
      project_name_changed(project_id, user_id, previous_attrs[:name], new_attrs[:name])
    end
    unless equal_or_both_blank?(previous_attrs[:project_category_id], new_attrs[:project_category_id])
      project_category_changed(project_id, user_id, previous_attrs[:project_category_id], new_attrs[:project_category_id])
    end
    unless equal_or_both_blank?(previous_attrs[:notes],new_attrs[:notes])
      project_notes_changed(project_id, user_id, previous_attrs[:notes], new_attrs[:notes])
    end
    unless equal_or_both_blank?(previous_attrs[:deadline], new_attrs[:deadline])
      project_deadline_changed(project_id, user_id, previous_attrs[:deadline], new_attrs[:deadline])
    end
  end

  def project_created(project_id, user_id, project_name)
      ProjectLogEntry.create!(
          :project_id => project_id,
          :user_id => user_id,
          :activity_type => :project_created,
          :new_value => project_name)
  end

  def project_deleted(project_id, user_id)
    ProjectLogEntry.create!(
      :project_id => project_id,
      :user_id => user_id,
      :activity_type => :project_deleted)
  end

  def project_closed(project_id, user_id)
    ProjectLogEntry.create!(
      :project_id => project_id,
      :user_id => user_id,
      :activity_type => :project_closed)
  end

  def project_reopened(project_id, user_id)
    ProjectLogEntry.create!(
      :project_id => project_id,
      :user_id => user_id,
      :activity_type => :project_reopened)
  end


  def project_name_changed(project_id, user_id, previous_name, new_name)
    ProjectLogEntry.create!(
      :project_id => project_id,
      :user_id => user_id,
      :activity_type => :project_name_changed,
      :previous_value => previous_name,
      :new_value => new_name)
  end

  def project_category_changed(project_id, user_id, previous_project_category_id, updated_project_category_id)
    ProjectLogEntry.create!(
        :project_id => project_id,
        :user_id => user_id,
        :activity_type => :project_category_changed,
        :previous_value => previous_project_category_id,
        :new_value => updated_project_category_id)
  end

  def project_notes_changed(project_id, user_id, previous_notes, new__notes)
    ProjectLogEntry.create!(
        :project_id => project_id,
        :user_id => user_id,
        :activity_type => :project_notes_changed,
        :previous_value => previous_notes,
        :new_value => new__notes)
  end

  def project_deadline_changed(project_id, user_id, previous_deadline, new_deadline)
    ProjectLogEntry.create!(
        :project_id => project_id,
        :user_id => user_id,
        :activity_type => :project_deadline_changed,
        :previous_value => previous_deadline,
        :new_value => new_deadline)
  end

private
  def equal_or_both_blank?(prev, new)
    prev == new || (prev.blank? && new.blank?)
  end
end