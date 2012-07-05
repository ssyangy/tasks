class CollaboratorsController < ApplicationController
  require 'pp'
  
  # GET /collaborators
  # GET /collaborators.json
  def index
    @project = Project.find(params[:project_id])
    @collaborators = @project.collaborators
    @collaborator = Collaborator.new
    respond_to do |format|
      format.html { render :layout => "admin" }# index.html.erb
      format.json { render json: @collaborators }
    end
  end

  # POST /collaborators
  # POST /collaborators.json
  def create
    @project = Project.find(params[:project_id])
    pp @user = User.find_by_email(params[:email])
    if @user.nil?
      redirect_to project_collaborators_url(@project), notice: "user '#{params[:email]}' does not exist."
      return
    end
    
    if @project.collaborators.find_by_user_id(@user.id)
      redirect_to project_collaborators_url(@project), notice: "user '#{params[:email]}' already exist."
      return
    end
    if @user.id == @project.owner.id
      redirect_to project_collaborators_url(@project), notice: "user '#{params[:email]}' already exist."
      return
    end
    
    @collaborator = @project.collaborators.build(:user_id => @user.id)

    respond_to do |format|
      if @collaborator.save
        format.html { redirect_to project_collaborators_url(@project), notice: 'Collaborator was successfully added.' }
        format.json { render json: @collaborator, status: :created, location: @collaborator }
      else
        format.html { render action: "new" }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaborators/1
  # DELETE /collaborators/1.json
  def destroy
    @project = Project.find(params[:project_id])
    @collaborator = Collaborator.find(params[:id])
    @collaborator.destroy

    respond_to do |format|
      format.html { redirect_to project_collaborators_url(@project) }
      format.json { head :no_content }
    end
  end



# not needed methods
private
  # GET /collaborators/1
  # GET /collaborators/1.json
  def show
    @collaborator = Collaborator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @collaborator }
    end
  end

  # GET /collaborators/new
  # GET /collaborators/new.json
  def new
    @project = Project.find(params[:project_id])
    @collaborator = Collaborator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @collaborator }
    end
  end

  # GET /collaborators/1/edit
  def edit
    @collaborator = Collaborator.find(params[:id])
  end

  # PUT /collaborators/1
  # PUT /collaborators/1.json
  def update
    @collaborator = Collaborator.find(params[:id])

    respond_to do |format|
      if @collaborator.update_attributes(params[:collaborator])
        format.html { redirect_to @collaborator, notice: 'Collaborator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

end
