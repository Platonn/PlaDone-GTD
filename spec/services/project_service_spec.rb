require "rails_helper"

describe ProjectService, :type => :service do
  before(:all) do
    User.delete_all
    Project.delete_all
  end

  let(:project_service)         { ProjectService.new }
  let(:user)                    { User.create(:email => 'test@test.com', :password => 'testtest') }
  let(:in_memory_project_form)  { ProjectForm.new(:name => 'TestName') }

  it "creates project" do
    project = project_service.create(in_memory_project_form, user)
    expect(project.persisted?).to eq true
  end

  context("just created project") do
    let(:project) { project_service.create(in_memory_project_form, user) }

    it "#get_project_by_id" do
      got_project = project_service.get_project_by_id(project.id, user)
      expect(got_project).to eq project
    end

    it "#update" do
      project_form = in_memory_project_form
      project_form.name = "name123"
      project_service.update(project.id, project_form, user)
      project.reload
      expect(project.name).to eq "name123"
    end

    it "#soft_delete" do
      project_service.soft_delete(project.id, user)
      project.reload
      expect(project.deleted_at).to be_truthy
    end
  end

  pending "#get_active_projects_of" # check if ordering is proper
end
