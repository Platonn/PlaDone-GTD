class Project < ActiveRecord::Base
  belongs_to  :users

  has_many    :tasks
  belongs_to  :project_category
  has_many    :project_log_entries

  #validate :name, :presence => true

  extend SoftDeletableStatic
  include SoftDeletable
end
