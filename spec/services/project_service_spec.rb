require "rails_helper"
#       project_service.project_log_service.should_receive #spike!
describe ProjectService, :type => :service do
  before(:all) do
    User.delete_all
    Project.delete_all
  end

  let(:project_service)         { ProjectService.new }
  let(:user)                    { User.create(:email => 'test@test.com', :password => 'testtest') }
  let(:in_memory_project_form)  { ProjectForm.new(:name => 'TestName') }

  describe "#create" do
    context "when name blank" do
      before do
        @project_form = in_memory_project_form.clone
        @project_form.name = ""
      end
      it "raises ValidationError" do
        expect{ project_service.create(@project_form, user) }.to raise_error(ProjectForm::ValidationError)
      end
    end

    context "when new name not blank" do
      it "creates project" do
        project = project_service.create(in_memory_project_form, user)
        expect(project.persisted?).to eq true
      end
    end
  end

  context("when project created") do
    let(:project) { project_service.create(in_memory_project_form, user) }

    describe "#get_project_by_id" do
      it "gets project by id" do
        got_project = project_service.get_project_by_id(project.id, user)
        expect(got_project).to eq project
      end
    end

    describe "#update" do
      context "when new name blank" do
        before do
          @project_form = in_memory_project_form.clone
          @project_form.name = ""
        end
        it "raises ValidationError" do
          expect{ project_service.update(project.id, @project_form, user) }.to raise_error(ProjectForm::ValidationError)
        end
      end
      context "when new name not blank" do
        it "updates name" do
          project_form = in_memory_project_form
          project_form.name = "name123"
          project_service.update(project.id, project_form, user)
          project.reload
          expect(project.name).to eq "name123"
        end
      end
    end

    describe "#soft_delete" do
      it "soft-deletes" do
        project_service.soft_delete(project.id, user)
        project.reload
        expect(project.deleted_at).to be_truthy
      end
    end
  end

 pending "#get_active_projects_of" # check if ordering is proper
end
