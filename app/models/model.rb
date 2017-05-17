class Model < ApplicationRecord
	has_many :units
	belongs_to :project, optional: true

	before_save :upcase

	private 

	def upcase
		self.package = self.package.upcase
	end
end
