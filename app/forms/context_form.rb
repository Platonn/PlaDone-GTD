class ContextForm
  ValidationError = Class.new(StandardError) #spike

  include Virtus.model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :name,  String
  attribute :color, String
  attribute :icon,  String

  validates :name, presence: true

  def persisted?
    false
  end

  def validate!
    raise ValidationError, errors unless valid?
  end
end