require "rails_helper"

describe TaskService, :type => :service do
  before(:all) do
    User.delete_all
    Task.delete_all
  end

  let(:task_service)        { TaskService.new }
  let(:user)                { User.create(:email => 'test@test.com', :password => 'testtest') }
  let(:in_memory_task_form) { TaskForm.new(:name => 'TestName') }

  it "creates task" do
    task = task_service.create(in_memory_task_form, user)
    expect(task.persisted?).to eq true
  end

  context("just created task") do
    let(:task) { task_service.create(in_memory_task_form, user) }

    it "#get_task_by_id" do
      got_task = task_service.get_task_by_id(task.id, user)
      expect(got_task).to eq task
    end

    it "#update" do
      task_form = in_memory_task_form
      task_form.name = "name123"
      task_service.update(task.id, task_form, user)
      task.reload
      expect(task.name).to eq "name123"
    end

    context("when undone") do
      before(:each) do
        task.done = false
        task.save!
      end
      it "#toggle_done" do
        task_service.toggle_done(task.id, user)
        task.reload
        expect(task.done).to be true
      end
    end
    context("when done") do
      before(:each) do
        task.done = true
        task.save!
      end
      it "#toggle_done" do
        task_service.toggle_done(task.id, user)
        task.reload
        expect(task.done).to be false
      end
    end

    it "#soft_delete" do
      task_service.soft_delete(task.id, user)
      task.reload
      expect(task.deleted_at).to be_truthy
    end
  end

  pending "#get_active_tasks_of" # check if ordering is proper
end
