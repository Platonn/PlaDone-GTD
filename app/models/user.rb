require 'rubygems'
require 'role_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks
  has_many :contexts
  has_many :projects
  has_many :project_categories

  # Roles:
  include RoleModel
  roles_attribute :roles_mask
  ### DO NOT CHANGE ORDER OF FOLLOWING ROLES! ALWAYS APPEND AT THE END:
  roles :admin, :banned

  def owns?(object)
    return  object.present? &&
            object.respond_to?('user_id') &&
            object.user_id == self.id
  end

  def can_use?(object)
    has_role?(:admin) || owns?(task)
  end
end