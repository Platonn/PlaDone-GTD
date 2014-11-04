class ProjectCategory < ActiveRecord::Base
  has_many :projects

  validate :name, :presence => true
end
