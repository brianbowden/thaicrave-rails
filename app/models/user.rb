class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :token

  # Pulled these into the User model since Devise 
  # support for authentication toekns was dropped
	def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
    save
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless self.class.unscoped.where(authentication_token: token).first
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
