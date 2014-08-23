class Picture < ActiveRecord::Base
  belongs_to :product
  
  mount_uploader :full_view, FullPictureUploader
  mount_uploader :zoom, FullPictureUploader
  mount_uploader :pattern, FullPictureUploader
  mount_uploader :full_view_thumb, ThumbPictureUploader
  mount_uploader :zoom_thumb, ThumbPictureUploader
  mount_uploader :pattern_thumb, ThumbPictureUploader
end
