class ProjectCategory < ActiveRecord::Base
  belongs_to :users

  has_many :projects

  #validate :name, :presence => true

  extend SoftDeletableStatic
  include SoftDeletable
end
