class ProjectCategory < ActiveRecord::Base
  belongs_to :user

  has_many :projects

  validate :name, :presence => true

  extend SoftDeletableStatic
  include SoftDeletable
end
