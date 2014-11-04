class Context < ActiveRecord::Base
  has_many :tasks

  extend SoftDeletableStatic
  include SoftDeletable
end
