class Api::V1::ManifestsController < ApplicationController
  def show
    rover = Rover.find_by name: params[:id].capitalize
    if rover.present?
      manifest = rover.photo_manifest
      render json: manifest, serializer: PhotoManifestSerializer, root: :photo_manifest
    else
      render json: { errors: "Invalid Rover Name" }, status: :bad_request
    end
  end
end
