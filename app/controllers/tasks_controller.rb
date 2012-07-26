class TasksController < ApplicationController
  require 'pp'
  layout 'twitter'
  before_filter :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.where('status = 0').order('created_at')
    
    # @tasks_row = @project.tasks.where('status = 0').order('due')
    # @tasks_row.each do |task|
    #   today = Date.today
    #   task_date = task.created_at.to_date
    # 
    #   case task.due
    #   when Task::DUE_ASAP
    #   when Task::DUE_TODAY
    #     if task_date < today
    #       task.due = Task::DUE_OVERDUE
    #     end
    #   when Task::DUE_TOMORROW
    #     if task_date + 1 == today
    #       task.due = Task::DUE_TODAY
    #     elsif task_date + 1 < today
    #       task.due = Task::DUE_OVERDUE
    #     end
    #   when Task::DUE_THISWEEK
    #     if today - task_date == 7 - task_date.wday - 2
    #       task.due = Task::DUE_TOMORROW
    #     elsif today - task_date == 7 - task_date.wday - 1
    #       task.due = Task::DUE_TODAY
    #     elsif today - task_date >= 7 - task_date.wday
    #       task.due = Task::DUE_OVERDUE
    #     end
    #   when Task::DUE_NEXTWEEK
    #     # TODO
    #   when Task::DUE_THISMONTH
    #     days_in_month = Time.days_in_month(Time.now.month)
    #     if today.month != task_date.month
    #       task.due = Task::DUE_OVERDUE
    #     elsif days_in_month - today.mday == 1
    #       task.due = Task::DUE_TOMORROW
    #     elsif days_in_month - today.mday == 0
    #       task.due = Task::DUE_TODAY
    #     # TODO. due_thisweek, due_nextweek
    #     end
    #   when Task::DUE_NEXTMONTH
    #     if (task_date >> 1).month != today.month
    #       task.due = Task::DUE_OVERDUE
    #     # elsif 
    #     #   task.due = Task::DUE_TOMORROW
    #     # elsif
    #     #   task.due = Task::DUE_TODAY
    #     # TODO. due_thisweek, due_nextweek
    #     elsif today.month == task_date.month
    #       task.due = Task::DUE_THISMONTH
    #     end 
    #   when Task::DUE_THISYEAR
    #     # TODO
    #   else
    #   end
    # end
    # 
    # @tasks = @tasks_row.sort_by &:due
    @task = Task.new
#    @tasks.sort! { |t| t.due }
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
    pp params[:task_id]
    pp @task = Task.find(params[:task_id])
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
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "people" } # show.html.erb
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
    @task = Task.parse(params[:task][:title])
    @task.project_id = @project.id
    @task.detail = params[:task][:detail]
    @task.author_id = current_user.id
    @task.assignee_id = params[:task][:assignee_id]
    pp @task

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
  
  
  # kind of list
  def people
    @project = Project.find(params[:project_id])
    @collaborators = @project.collaborators
    
    render :layout => "people"
  end
end
