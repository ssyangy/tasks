class Attachment < ActiveRecord::Base
	require 'pp'
  
  attr_accessor :tmp_file_path
  before_save :save_to_file
  

   #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "name" => self.file_name,
      "url" => self.url_path
    }
  end 

  def save_to_file
    require 'fileutils'
    check_store_dir
    
    file_store = File.join Rails.root, 'public', 'attachments'
    ext_name = File.extname(self.file_name)

    uuid = UUID.new
    unique_name = uuid.generate + ext_name
    self.file_path = File.join(file_store, unique_name)
    self.url_path = File.join('/', 'attachments', unique_name)
    
    FileUtils.cp self.tmp_file_path, self.file_path
  end
    
  def file=(file_field)
  	self.content_type = file_field.content_type.chomp
    self.file_name = file_field.original_filename
    self.tmp_file_path = file_field.tempfile
  end
  
  private
  def check_store_dir
    file_store = File.join Rails.root, 'public', 'attachments'
    if not File.directory?(file_store)
      Dir.mkdir(file_store)
    end
  end

end
