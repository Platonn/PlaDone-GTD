class Project < ActiveRecord::Base
  has_many :tasks
  belongs_to :project_category

  validate :name, :presence => true

  extend SoftDeletableStatic
  include SoftDeletable
end
