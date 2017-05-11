class Layout < ApplicationRecord
	belongs_to :project, optional: true
	has_many :units

	mount_uploader :plan, LayoutUploader
	mount_uploaders :pictures, LayoutUploader
	serialize :pictures, JSON
end
