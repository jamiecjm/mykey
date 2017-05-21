class UnitsController < ApplicationController
	before_action :admin, only: [:new,:create,:index,:edit,:update,:destroy]

	def new
		@unit = Unit.new
	end

	def create
		@unit = Unit.new(unit_params)
		@unit.save
		@unit.update(model_layout_params)
		flash[:success] = "Unit created"
		redirect_to "/"
	end

	def index
		@units = Unit.includes(:model,:project,:user,:layout)
	end

	def show
		@unit = Unit.find(params[:id])
	end

	def dynamic_options
		@project = Project.find(params[:id])
		render "units/dynamic_options.html.erb", :layout => false
	end

	def edit
		@unit = Unit.find(params[:id])
	end

	def update
		@unit = Unit.find(params[:id])
		@unit.update(update_params)	
		@unit.update(model_layout_params) if params[:model_id] != nil
		flash[:success] = "Unit updated"
		redirect_to units_path
	end

	def destroy
		unit = Unit.find(params[:id])
		unit.destroy
		redirect_to "/units"
	end

	private

	def unit_params
		params.require(:unit).permit(:user_id,:project_id,:unit_no,:net_value)
	end

	def model_layout_params
		params.permit(:model_id,:layout_id)
	end

	def update_params
		params.require(:unit).permit(:user_id,:project_id,:unit_no,:net_value,:model_id,:layout_id)
	end
end
