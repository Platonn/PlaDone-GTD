class Task < ActiveRecord::Base
  belongs_to :project
  has_one: :context

  validates :name, :presence => true
end
