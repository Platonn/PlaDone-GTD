require 'rails_helper'

RSpec.describe "ProjectLogEntries", :type => :request do
  describe "GET /project_log_entries" do
    it "works! (now write some real specs)" do
      get project_log_entries_path
      expect(response).to have_http_status(200)
    end
  end
end
