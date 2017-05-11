class ProjectsController < ApplicationController


	def new
		@project = Project.new
	end

	def create
		ActiveRecord::Base.transaction do
			@project = Project.new(project_params)
			@project.save
			redirect_to project_path(@project)
		end
	end

	def show
		@project = Project.find(params[:id])
	end

	def all
		@projects = Project.all
	end

	def user
		@projects = current_user.projects
	end

	private

	def project_params
		params.require(:project).permit(:name,
			models_attributes:[:id,:package,:_destroy],
			layouts_attributes:[:id,:_destroy,:size,:plan,{pictures: []}])
	end


end
