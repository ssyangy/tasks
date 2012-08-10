class AttachmentsController < ApplicationController
	require 'pp'

	def destroy
		attachment = Attachment.find(params[:id])
		attachment.destroy
		
    respond_to do |format|
      format.html { redirect_to project_tasks_url(@project), notice: 'Attachment was successfully deleted.' }
      format.json { head :no_content }
    end
	end
end
