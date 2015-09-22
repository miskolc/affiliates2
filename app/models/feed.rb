class Feed < ActiveRecord::Base
  belongs_to :user
  mount_uploaders :file, FileUploader
end
