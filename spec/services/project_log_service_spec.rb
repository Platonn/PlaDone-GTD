require "rails_helper"

describe ProjectLogService, :type => :service do
  let(:project_log_service) { ProjectLogService.new }
  let(:project_id)          { 12345 }
  let(:user_id)             { 123 }

  describe "#project_created" do
    let(:project_name) {'ProjectName1'}
    it "sets activity_type to project_created" do
      project_log_entry = project_log_service.project_created(project_id, user_id, project_name)
      expect(project_log_entry.activity_type).to eq "project_created"
    end
  end

  describe "#project_deleted" do
    it "sets activity_type to project_deleted" do
      project_log_entry = project_log_service.project_deleted(project_id, user_id)
      expect(project_log_entry.activity_type).to eq "project_deleted"
    end
  end

  describe "#project_closed" do
    it "sets activity_type to project_closed" do
      project_log_entry = project_log_service.project_closed(project_id, user_id)
      expect(project_log_entry.activity_type).to eq "project_closed"
    end
  end

  describe "#project_reopened" do
    it "sets activity_type to project_reopened" do
      project_log_entry = project_log_service.project_reopened(project_id, user_id)
      expect(project_log_entry.activity_type).to eq "project_reopened"
    end
  end

  describe "#project_name_changed" do
    let(:previous_name) {'Prev name'}
    let(:new_name)      {'New name'}
    it "sets activity_type to project_name_changed" do
      project_log_entry = project_log_service.project_name_changed(project_id, user_id, previous_name, new_name)
      expect(project_log_entry.activity_type).to eq "project_name_changed"
    end
  end

  describe "#project_category_changed" do
    let(:previous_project_category_id) {111}
    let(:new_project_category_id)      {222}
    it "sets activity_type to project_category_changed" do
      project_log_entry = project_log_service.project_category_changed(project_id, user_id, previous_project_category_id, new_project_category_id)
      expect(project_log_entry.activity_type).to eq "project_category_changed"
    end
  end

  describe "#project_notes_changed" do
    let(:previous_notes) {'Previous notes'}
    let(:new_notes)      {'New notes'}
    it "sets activity_type to project_notes_changed" do
      project_log_entry = project_log_service.project_notes_changed(project_id, user_id, previous_notes, new_notes)
      expect(project_log_entry.activity_type).to eq "project_notes_changed"
    end
  end

  describe "#project_deadline_changed" do
    let(:previous_deadline) { DateTime.new(2015, 01, 01, 00, 00, 00) }
    let(:new_deadline)      { DateTime.new(2015, 01, 02, 10, 00, 00) }
    it "sets activity_type to project_deadline_changed" do
      project_log_entry = project_log_service.project_deadline_changed(project_id, user_id, previous_deadline, new_deadline)
      expect(project_log_entry.activity_type).to eq "project_deadline_changed"
    end
  end
end

=begin #spike:

:project_created,
:project_deleted,
:project_closed,
:project_reopened,
:project_name_changed,
:project_category_changed
:project_notes_changed,
:project_deadline_changed


  t.string   "name"
  t.integer  "project_category_id"
  t.datetime "created_at"
  t.datetime "updated_at"
  t.datetime "deadline"
  t.time     "deleted_at"
  t.text     "notes"
  t.integer  "user_id"

=end