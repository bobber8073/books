class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :registerable, :recoverable, :rememberable, :trackable, :timeoutable and :omniauthable
  devise :database_authenticatable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me  
  
end
