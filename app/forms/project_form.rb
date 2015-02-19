class ProjectForm
  ValidationError = Class.new(StandardError) #spike

  include Virtus.model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :name,                String
  attribute :deadline,            DateTime
  attribute :project_category_id, Integer
  attribute :notes,               String

  validates :name, presence: true

  def persisted?
    false
  end

  def validate!
    raise ValidationError, errors unless valid?
  end
end