require "rails_helper"

describe ProjectCategoryService, :type => :service do
  before(:all) do
    User.delete_all
    ProjectCategory.delete_all
  end

  let(:project_category_service)        { ProjectCategoryService.new }
  let(:user)                { User.create(:email => 'test@test.com', :password => 'testtest') }
  let(:in_memory_project_category_form) { ProjectCategoryForm.new(:name => 'TestName') }

  it "creates project_category" do
    project_category = project_category_service.create(in_memory_project_category_form, user)
    expect(project_category.persisted?).to eq true
  end

  context("just created project_category") do
    let(:project_category) { project_category_service.create(in_memory_project_category_form, user) }

    it "#get_project_category_by_id" do
      got_project_category = project_category_service.get_project_category_by_id(project_category.id, user)
      expect(got_project_category).to eq project_category
    end

    it "#update" do
      project_category_form = in_memory_project_category_form
      project_category_form.name = "name123"
      project_category_service.update(project_category.id, project_category_form, user)
      project_category.reload
      expect(project_category.name).to eq "name123"
    end

    it "#soft_delete" do
      project_category_service.soft_delete(project_category.id, user)
      project_category.reload
      expect(project_category.deleted_at).to be_truthy
    end

    describe "validations" do
      describe "name" do
        context "when blank" do
          before do
            @project_category_form = in_memory_project_category_form.clone
            @project_category_form.name = ""
          end
          describe "#create" do
            it "raises ValidationError" do
              expect{ project_category_service.create(@project_category_form, user) }.to raise_error(ProjectCategoryForm::ValidationError)
            end
          end
          describe "#update" do
            it "raises ValidationError" do
              expect{ project_category_service.update(project_category.id, @project_category_form, user) }.to raise_error(ProjectCategoryForm::ValidationError)
            end
          end
        end
      end
    end
  end

  pending "#get_active_project_categories_of" # check if ordering is proper
end
