class ProjectController < ApplicationController
  
  before_action :authenticate_user!, only: [:list]
  
  def index
  	@projects = Project.all
  end

  def show
  	@project = Project.find(params[:id])
  	@tasks = @project.tasks.order(:tag)

  	@joined = false

  	if !current_user.nil? && !current_user.projects.nil?
  		#check if @project is already inside current_user's project. if current user already joined project
  		@joined = current_user.projects.include?(@project)
  	end

  	@users = @project.users.order('created_at desc').first(10)

    #initialize new, blank instance of review
    @review = Review.new
    #get list of all reviews in this project
    @reviews = @project.reviews

    #check if user already has review
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def list
    if !current_user.nil?
      @projects = current_user.projects
    end
  end

end

