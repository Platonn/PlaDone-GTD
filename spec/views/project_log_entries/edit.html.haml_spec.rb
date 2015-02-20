require 'rails_helper'

RSpec.describe "project_log_entries/edit", :type => :view do
  before(:each) do
    @project_log_entry = assign(:project_log_entry, ProjectLogEntry.create!(
      :project_id => 1,
      :task_id => 1,
      :user_id => 1,
      :activity_type => 1
    ))
  end

  it "renders the edit project_log_entry form" do
    render

    assert_select "form[action=?][method=?]", project_log_entry_path(@project_log_entry), "post" do

      assert_select "input#project_log_entry_project_id[name=?]", "project_log_entry[project_id]"

      assert_select "input#project_log_entry_task_id[name=?]", "project_log_entry[task_id]"

      assert_select "input#project_log_entry_user_id[name=?]", "project_log_entry[user_id]"

      assert_select "input#project_log_entry_activity_type[name=?]", "project_log_entry[activity_type]"
    end
  end
end
