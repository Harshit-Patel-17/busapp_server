class User < ActiveRecord::Base
  has_one :privilege, :dependent => :delete
  has_one :role, through: :privilege
  has_one :bus 

  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         :token_authenticatable
end
