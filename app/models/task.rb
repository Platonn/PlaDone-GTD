class Task < ActiveRecord::Base
  belongs_to :project

  validates :description, :presence => true
end
