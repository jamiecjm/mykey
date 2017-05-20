class Unit < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :project, optional: true
	belongs_to :layout, optional: true
	belongs_to :model, optional: true

	before_save :upcase

	validates :unit_no, uniqueness: {scope: :project_id, message: "This unit has already been created!"}

	def upcase
		self.unit_no = self.unit_no.upcase
	end
end
