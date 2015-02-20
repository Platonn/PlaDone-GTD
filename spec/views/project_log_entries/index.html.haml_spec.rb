require 'rails_helper'

RSpec.describe "project_log_entries/index", :type => :view do
  before(:each) do
    assign(:project_log_entries, [
      ProjectLogEntry.create!(
        :project_id => 1,
        :task_id => 2,
        :user_id => 3,
        :activity_type => 4
      ),
      ProjectLogEntry.create!(
        :project_id => 1,
        :task_id => 2,
        :user_id => 3,
        :activity_type => 4
      )
    ])
  end

  it "renders a list of project_log_entries" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
