class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer       :task_id,     :null => false
      t.string		  	:file_name,		:null => false
      t.string        :file_path,   :null => false
      t.string        :url_path,    :null => false
      t.string        :content_type
      
      t.timestamps
    end
  end
end
