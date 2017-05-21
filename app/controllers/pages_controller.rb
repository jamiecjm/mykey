class PagesController < ApplicationController

	def index
	end

	def account
	end

	def open_image_modal
		@layout = Layout.find(params[:layout_id])
		@slide = params[:slide_id]
		respond_to do |format|
			format.js
		end
	end
end
