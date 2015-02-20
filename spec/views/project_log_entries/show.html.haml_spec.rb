require 'rails_helper'

RSpec.describe "project_log_entries/show", :type => :view do
  before(:each) do
    @project_log_entry = assign(:project_log_entry, ProjectLogEntry.create!(
      :project_id => 1,
      :task_id => 2,
      :user_id => 3,
      :activity_type => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
