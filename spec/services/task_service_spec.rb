require "rails_helper"

describe TaskService, :type => :service do
  before(:all) do
    User.delete_all
    Task.delete_all
  end

  let(:task_service)         { TaskService.new }
  let(:user)                 { User.create(:email => 'test@test.com', :password => 'testtest') }
  let(:in_memory_task_form)  { TaskForm.new(:name => 'TestName') }

  describe "#create" do
    context "when name blank" do
      before do
        @task_form = in_memory_task_form.clone
        @task_form.name = ""
      end
      it "raises ValidationError" do
        expect{ task_service.create(@task_form, user) }.to raise_error(TaskForm::ValidationError)
      end
    end

    context "when new name not blank" do
      it "creates task" do
        task = task_service.create(in_memory_task_form, user)
        expect(task.persisted?).to eq true
      end
    end
  end

  context("when task created") do
    let(:task) { task_service.create(in_memory_task_form, user) }

    describe "#get_task_by_id" do
      it "gets task by id" do
        got_task = task_service.get_task_by_id(task.id, user)
        expect(got_task).to eq task
      end
    end

    describe "#update" do
      context "when new name blank" do
        before do
          @task_form = in_memory_task_form.clone
          @task_form.name = ""
        end
        it "raises ValidationError" do
          expect{ task_service.update(task.id, @task_form, user) }.to raise_error(TaskForm::ValidationError)
        end
      end
      context "when new name not blank" do
        it "updates name" do
          task_form = in_memory_task_form
          task_form.name = "name123"
          task_service.update(task.id, task_form, user)
          task.reload
          expect(task.name).to eq "name123"
        end
      end
    end

    describe "#soft_delete" do
      it "soft-deletes" do
        task_service.soft_delete(task.id, user)
        task.reload
        expect(task.deleted_at).to be_truthy
      end
    end
  end

  pending "#get_active_tasks_of" # check if ordering is proper
end
