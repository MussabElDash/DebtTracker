class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :timeoutable
	devise :database_authenticatable, :registerable, :omniauthable,
		   :recoverable, :rememberable, :trackable, :validatable,
		   :confirmable, :lockable, :omniauth_providers => [:facebook, :google]

	# Methods
	def self.from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize do |user|
    		user.email = auth.info.email
    		user.password = Devise.friendly_token[0,20]
    		user.first_name = auth.info.first_name
    		user.last_name = auth.info.last_name
    		user.image = auth.info.image
    		user.skip_confirmation!
    		user.save!
  		end
	end

	def self.new_with_session(params, session)
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			elsif data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			end
		end
	end
end
