class TaskController < ApplicationController

	before_action :authenticate_user!

  def show
  	project = Project.find(params[:project_id])
  	@tasks = project.tasks.order(:tag)

  	joined = false

  	if !current_user.nil? && !current_user.projects.nil?
  		#check if @project is already inside current_user's project. if current user already joined project
  		joined = current_user.projects.include?(@project)
  	end

  	if joined
  	  @task = @tasks.find(params[:id])
	  	@next_task = @task.next
	  	@prev_task = @task.prev
	  else
	  	flash[:notice] = "No permission to view this. Please take this project."
	  	redirect_to project
	  end
  end
  
end
