class ContextService
  def get_context_by_id(context_id, current_user)
    context = find_context_by_id(context_id)
    current_user.can_use?(context) ? context : nil
  end

  def get_active_contexts_of(user)
    user.contexts.active.order(:name)
  end

  def create(context_form, creator_user)
    context_form.validate!
    context = creator_user.contexts.build(context_form.attributes)
    creator_user.save!
    return context
  end

  def update(context_id, context_form, current_user)
    context_form.validate!
    context = find_context_by_id(context_id)
    current_user.can_use?(context) ? context.update(context_form.attributes) : nil
  end

  def soft_delete(context_id, current_user)
    context = find_context_by_id(context_id)
    current_user.can_use?(context) ? context.soft_delete : nil
  end

  private
  def find_context_by_id(context_id)
    context = Context.find(context_id)
  end
end