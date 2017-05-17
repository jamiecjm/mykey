class ProjectsController < ApplicationController


	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		if @project.save
			flash[:success] = "Project has been created."
			redirect_to project_path(@project)
		else
			# flash.now[:danger] = @project.errors.full_messages
			render "new", alert: @project.errors.full_messages
		end
	end

	def show
		@project = Project.find(params[:id])
	end

	def index
		@projects = Project.all
	end

	def user
		@projects = current_user.projects
	end

	def units
		@project= params[:project_id]
		@units = @project.units.includes(:model,:project,:user,:layout)
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
		byebug
	end

	private

	def project_params
		params.require(:project).permit(:name,
			models_attributes:[:id,:package,:_destroy],
			layouts_attributes:[:id,:_destroy,:size,:plan,{pictures: []}])
	end


end
