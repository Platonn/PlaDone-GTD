class Context < ActiveRecord::Base
  belongs_to :user

  has_many :tasks

  extend SoftDeletableStatic
  include SoftDeletable
end
