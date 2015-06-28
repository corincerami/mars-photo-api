class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :sol, :camera, :img_src, :earth_date

  has_one :rover
end
