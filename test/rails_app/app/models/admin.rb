if DEVISE_ORM == :dynamoid
    require 'dynamoid'
end

class Admin < PARENT_MODEL_CLASS
    case DEVISE_ORM
    when :mongoid
        include Mongoid::Document
        include Mongoid::Attributes::Dynamic if defined?(Mongoid::Attributes::Dynamic)
        ## Database authenticatable
        field :email, type: String, default: ""
        field :encrypted_password, type: String, default: ""
        validates_presence_of :email
        validates_presence_of :encrypted_password, if: :password_required?

        ## Confirmable
        field :confirmation_token, type: String
        field :confirmed_at, type: Time
        field :confirmation_sent_at, type: Time
        field :unconfirmed_email, type: String # Only if using reconfirmable

        devise :database_authenticatable, :validatable, :registerable
    when :dynamoid
        include Dynamoid::Document

        # Table properties
        table name: :admins, key: :id, capacity_mode: :on_demand

        # Database authenticatable
        field :email, :string, default: ''
        field :encrypted_password, :string, default: ''

        validates_presence_of :email
        validates_presence_of :encrypted_password, if: :password_required?

        # Confirmable
        field :confirmation_token, :string
        field :confirmed_at, :datetime
        field :confirmation_sent_at, :datetime
        field :unconfirmed_email, :string

        devise :database_authenticatable, :registerable
    when :active_record
        devise :database_authenticatable, :validatable, :registerable
    end

    include DeviseInvitable::Inviter
end
