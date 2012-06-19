class TasksController < ApplicationController
  layout 'twitter'
  before_filter :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
#    @tasks = current_user.todos.where('status = 0').order('created_at DESC')
#    @completed = current_user.todos.where('status = 1').order('updated_at DESC')
  #  @tasks = Task.where('status = 0').order("content")
  #  @completed = Task.where('status = 1').order("updated_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end        
  
  def complete 
    @task = Task.find(params[:id])
    @task.status = 1
    @task.save
    
    respond_to do |format|
      format.js
    end
  end

  def uncomplete 
    @task = Task.find(params[:id])
    @task.status = 0
    @task.save
    
    respond_to do |format|
      format.js
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
    @task.status = 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @project = Project.find(params[:project_id])
    Task.parse(params[:content])
    @task = @project.tasks.build(:content => params[:content])
#    @task = Task.new(params[:task])
#    @task.author_id = 

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_url(@project), notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to project_tasks_url(@project), notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.js
    #  format.html { redirect_to tasks_url }
    #  format.json { head :no_content }
    end
  end
end
