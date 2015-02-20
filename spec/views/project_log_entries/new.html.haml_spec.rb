require 'rails_helper'

RSpec.describe "project_log_entries/new", :type => :view do
  before(:each) do
    assign(:project_log_entry, ProjectLogEntry.new(
      :project_id => 1,
      :task_id => 1,
      :user_id => 1,
      :activity_type => 1
    ))
  end

  it "renders new project_log_entry form" do
    render

    assert_select "form[action=?][method=?]", project_log_entries_path, "post" do

      assert_select "input#project_log_entry_project_id[name=?]", "project_log_entry[project_id]"

      assert_select "input#project_log_entry_task_id[name=?]", "project_log_entry[task_id]"

      assert_select "input#project_log_entry_user_id[name=?]", "project_log_entry[user_id]"

      assert_select "input#project_log_entry_activity_type[name=?]", "project_log_entry[activity_type]"
    end
  end
end
