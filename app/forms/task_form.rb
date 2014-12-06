class TaskForm
  ValidationError = Class.new(StandardError) #spike

  include Virtus.model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :name,        String
  attribute :done,        Boolean
  attribute :deadline,    DateTime
  attribute :project_id,  Integer
  attribute :context_id,  Integer
  attribute :time_needed, String
  attribute :postponed_to,Date

  validates :name, presence: true

  def persisted?
    false
  end

  def validate!
    raise ValidationError, errors unless valid?
  end
end