class Context < ActiveRecord::Base
  belongs_to :users

  has_many :tasks

  extend SoftDeletableStatic
  include SoftDeletable
end
