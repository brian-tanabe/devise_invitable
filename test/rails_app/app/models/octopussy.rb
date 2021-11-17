# This model is here for the generators' specs
class Octopussy < PARENT_MODEL_CLASS
  if DEVISE_ORM == :mongoid
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic if defined?(Mongoid::Attributes::Dynamic)

    ## Database authenticatable
    field :email,              type: String, default: ""
    field :encrypted_password, type: String, default: ""
    validates_presence_of :email
    validates_presence_of :encrypted_password, if: :password_required?
  elsif DEVISE_ORM == :dynamoid
    include Dynamoid::Document

    ## Database authenticatable
    field :email, :string, default: ""
    field :encrypted_password, :string, default: ""
    validates_presence_of :email
    validates_presence_of :encrypted_password, if: :password_required?
  end

  if DEVISE_ORM == :dynamoid
    devise :database_authenticatable, :confirmable
  else
    devise :database_authenticatable, :validatable, :confirmable
  end
end
