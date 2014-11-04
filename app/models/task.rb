class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :context

  validates :name, :presence => true
end
