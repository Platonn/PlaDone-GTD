require "rails_helper"

describe ContextService, :type => :service do
  before(:all) do
    User.delete_all
    Context.delete_all
  end

  let(:context_service)         { ContextService.new }
  let(:user)                    { User.create(:email => 'test@test.com', :password => 'testtest') }
  let(:in_memory_context_form)  { ContextForm.new(:name => 'TestName') }

  it "creates context" do
    context = context_service.create(in_memory_context_form, user)
    expect(context.persisted?).to eq true
  end

  context("just created context") do
    let(:context) { context_service.create(in_memory_context_form, user) }

    it "#get_context_by_id" do
      got_context = context_service.get_context_by_id(context.id, user)
      expect(got_context).to eq context
    end

    it "#update" do
      context_form = in_memory_context_form
      context_form.name = "name123"
      context_service.update(context.id, context_form, user)
      context.reload
      expect(context.name).to eq "name123"
    end

    it "#soft_delete" do
      context_service.soft_delete(context.id, user)
      context.reload
      expect(context.deleted_at).to be_truthy
    end

    describe "validations" do
      describe "name" do
        context "when blank" do
          before do
            @context_form = in_memory_context_form.clone
            @context_form.name = ""
          end
          describe "#create" do
            it "raises ValidationError" do
              expect{ context_service.create(@context_form, user) }.to raise_error(ContextForm::ValidationError)
            end
          end
          describe "#update" do
            it "raises ValidationError" do
              expect{ context_service.update(context.id, @context_form, user) }.to raise_error(ContextForm::ValidationError)
            end
          end
        end
      end
    end
  end

  pending "#get_active_contexts_of" # check if ordering is proper
end
