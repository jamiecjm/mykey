class Model < ApplicationRecord
	has_many :units
	belongs_to :project, optional: true
end
