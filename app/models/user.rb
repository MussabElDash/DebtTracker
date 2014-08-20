class User < ActiveRecord::Base
	# Virtual attribute for authenticating by either username or email
	# This is in addition to a real persisted field like 'username'
	attr_accessor :login

	# Include default devise modules. Others available are:
	# :timeoutable
	devise :database_authenticatable, :registerable, :omniauthable,
		:recoverable, :rememberable, :trackable, :validatable,
		:confirmable, :lockable, :omniauth_providers => [:facebook, :google]

	# Associations
	has_many :debts_creditor, class_name: 'Debt', foreign_key: :creditor_id, dependent: :destroy
	has_many :debts_debtor, class_name: 'Debt', foreign_key: :debtor_id, dependent: :destroy

	# Validations
	before_save :downcase_login
	validates :email, presence: true
	validates :user_name, format: { with: /\A[A-Za-z\d]+[A-Za-z\-\d]*\z/, message: "may only contain alphanumeric characters or dashes and cannot begin with a dash." }
	validates :password, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true

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

	def name
		"#{first_name} #{last_name}"
	end

	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions).where(["lower(user_name) = :value OR lower(email) = :value",
				{ :value => login.downcase }]).first
		else
			where(conditions).first
		end
	end

	def self.find_by_login(login)
		where(conditions).where(["lower(user_name) = :value OR lower(email) = :value",
				{ :value => login.downcase }]).first
	end

	private
		def downcase_login
			self.email = self.email.downcase
			self.user_name = self.user_name.downcase if self.user_name.present?
		end
end
