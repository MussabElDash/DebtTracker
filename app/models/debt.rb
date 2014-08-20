class Debt < ActiveRecord::Base
	# Associations
	belongs_to :creditor, class_name: 'User'
	belongs_to :debtor, class_name: 'User'
	counter_culture :creditor, column_name: :creditor_total, delta_column: :remaining
	counter_culture :debtor, column_name: :debtor_total, delta_column: :remaining

	# Validations
	before_create :validate_confirmed_at
	before_validation :fill_remaining
	validate :valid_remaining
	validates :amount, presence: true
	validates :remaining, presence: true
	validates :creditor, presence: true
	validates :debtor, presence: true

	# Methods
	def skip_confirmation!
		self.confirmed_at = Time.now
	end

	def skip_remaining!
		self.remaining = self.amount
	end

private
	def validate_confirmed_at
		if self.confirmed_at.present? and self.confirmed_at < Time.now
			self.confirmed_at = Time.now
		end
	end

	def fill_remaining
		if self.remaining.nil? and self.confirmed_at.present?
			self.remaining = self.amount 
		elsif self.confirmed_at.nil?
			self.remaining = 0
		end
	end

	def valid_remaining
		if self.remaining.present? and (self.remaining > self.amount or self.reamaining < 0)
			self.reload
			errors.add(:remaining, "must be less than or equal the amount and bigger than or equal zero")
		end
	end
end
