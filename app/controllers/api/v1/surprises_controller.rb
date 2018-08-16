class Api::V1::SurprisesController < ApplicationController

  def index
    surprises = photos.sample(count.to_i)
    render json: surprises, root: :photos
  end

  private

  def photos
    photos = Photo.all
    photos = by_sol photos
    photos = by_earth_date photos
    photos = by_camera photos
    photos = by_rover photos
    photos
  end

  def by_sol(scope)
    params[:sol].present? ? scope.where(sol: params[:sol]) : scope
  end

  def by_earth_date(scope)
    params[:earth_date].present? ? scope.where(earth_date: params[:earth_date]) : scope
  end

  def by_rover(scope)
    params[:rover].present? ? scope.joins(:rover).where(rovers: {name: params[:rover].capitalize}) : scope
  end

  def by_camera(scope)
    params[:camera].present? ? scope.joins(:camera).where(cameras: {name: params[:camera].upcase}) : scope
  end

  def count
    n = params[:count].to_i
    n = 1 if n < 1
    n = 100 if n > 100
    n
  end
end
