class PhotoManifestSerializer < ActiveModel::Serializer
  attributes :name, :landing_date, :launch_date, :status, :max_sol, :max_date, :total_photos, :photos
end
