class PhotoSerializer < ActiveModel::Serializer
  attributes :sol, :camera, :img_src, :earth_date
end
