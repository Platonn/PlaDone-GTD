class Context < ActiveRecord::Base
  has_many :tasks

  validate :name, :presence => true
end
