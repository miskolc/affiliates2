class Feed < ActiveRecord::Base
  belongs_to :user
  mount_uploaders :file, FileUploader

  def storage_path
    directory = File.dirname self.file[0].path
    basename = File.basename(self.file[0].path).split("\"")[1]
    File.join directory, basename
  end
end
