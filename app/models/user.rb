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

  def self.create_new params
    user = User.new
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password = params[:password]
    user.save
    privilege = Privilege.new
    privilege.user_id = user.id
    privilege.role_id = Role.find_by_role_name(params[:role]).id
    privilege.save
  end
end
