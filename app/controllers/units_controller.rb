class UnitsController < ApplicationController

	def new
		@unit = Unit.new
	end

	def create
		@unit = Unit.new(unit_params)
		@unit.save
		@unit.update(model_layout_params)
		redirect_to "/"
	end

	def show
		@unit = Unit.find(params[:id])
	end

	def dynamic_options
		@project = Project.find(params[:id])
		render "units/dynamic_options.html.erb", :layout => false
	end

	private

	def unit_params
		params.require(:unit).permit(:user_id,:project_id,:unit_no,:net_value)
	end

	def model_layout_params
		params.permit(:model_id,:layout_id)
	end
end
