class Unit < ApplicationRecord
	belongs_to :user
	belongs_to :project
	belongs_to :layout
	belongs_to :model

	before_save :upcase


	def upcase
		self.unit_no = self.unit_no.upcase
	end
end
