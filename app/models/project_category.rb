class ProjectCategory < ActiveRecord::Base
  has_many :projects

  validate :name, :presence => true

  extend SoftDeletableStatic
  include SoftDeletable
end
