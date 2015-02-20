require "rails_helper"

describe ContextService, :type => :service do
  before(:all) do
    User.delete_all
    Context.delete_all
  end

  let(:context_service)         { ContextService.new }
  let(:user)                    { User.create(:email => 'test@test.com', :password => 'testtest') }
  let(:in_memory_context_form)  { ContextForm.new(:name => 'TestName') }

  describe "#create" do
    context "when name blank" do
      before do
        @context_form = in_memory_context_form.clone
        @context_form.name = ""
      end
      it "raises ValidationError" do
        expect{ context_service.create(@context_form, user) }.to raise_error(ContextForm::ValidationError)
      end
    end

    context "when new name not blank" do
      it "creates context" do
        context = context_service.create(in_memory_context_form, user)
        expect(context.persisted?).to eq true
      end
    end
  end

  context("when context created") do
    let(:context) { context_service.create(in_memory_context_form, user) }

    describe "#get_context_by_id" do
      it "gets context by id" do
        got_context = context_service.get_context_by_id(context.id, user)
        expect(got_context).to eq context
      end
    end

    describe "#update" do
      context "when new name blank" do
        before do
          @context_form = in_memory_context_form.clone
          @context_form.name = ""
        end
        it "raises ValidationError" do
          expect{ context_service.update(context.id, @context_form, user) }.to raise_error(ContextForm::ValidationError)
        end
      end
      context "when new name not blank" do
        it "updates name" do
          context_form = in_memory_context_form
          context_form.name = "name123"
          context_service.update(context.id, context_form, user)
          context.reload
          expect(context.name).to eq "name123"
        end
      end
    end

    describe "#soft_delete" do
      it "soft-deletes" do
        context_service.soft_delete(context.id, user)
        context.reload
        expect(context.deleted_at).to be_truthy
      end
    end
  end

  pending "#get_active_contexts_of" # check if ordering is proper
end
