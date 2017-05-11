class Project < ApplicationRecord
	has_many :units, dependent: :destroy
	has_many :models, dependent: :destroy
	has_many :layouts, dependent: :destroy
	has_many :users

	accepts_nested_attributes_for :layouts, :allow_destroy => true
	accepts_nested_attributes_for :models, :allow_destroy => true

	def user_units(user)
		self.units.where("units.user_id = ?",user.id)
	end

end
