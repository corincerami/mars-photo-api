module PhotoHelper

  def search_photos rover, params
    photos = rover.photos.order(:camera_id, :id).search params, rover

    if params[:page]
      photos = photos.page(params[:page]).per params[:per_page]
    end

    photos
  end

  def resize_photo photo, params

    error = nil;
    rover_name = Rover.find_by( id: photo[:rover_id] )[:name].downcase

    case params[:size]
    when nil, "large" # do nothing
    when "small"
      case rover_name
      when "curiosity"
        replace_photo_suffix photo, ".jpg", "-thm.jpg"
      when "spirit", "opportunity"
        replace_photo_suffix photo, ".jpg", "-THM.jpg"
      when "perseverance"
        replace_photo_suffix photo, "1200.jpg", "320.jpg"
      else
        error = "Invalid size parameter 'small' for '#{rover_name.titleize}' rover";
      end
    when "medium"
      if rover_name == "perseverance"
        replace_photo_suffix photo, "1200.jpg", "800.jpg"
      else
        error = "Invalid size parameter 'medium' for '#{rover_name.titleize}' rover";
      end
    when "full"
      if rover_name == "perseverance"
        replace_photo_suffix photo, "_1200.jpg", ".png"
      else
        error = "Invalid size parameter 'full' for '#{rover_name.titleize}' rover";
      end
    else
      error = "Unrecognized size parameter: '#{params[:size]}'";
    end

    error
  end

  def resize_photos photos, params

    error = nil;
    rover_name = params[:rover_id].downcase

    case params[:size]
    when nil, "large" # do nothing
    when "small"
      case rover_name
      when "curiosity"
        replace_each_photo_suffix photos, ".jpg", "-thm.jpg"
      when "spirit", "opportunity"
        replace_each_photo_suffix photos, ".jpg", "-THM.jpg"
      when "perseverance"
        replace_each_photo_suffix photos, "1200.jpg", "320.jpg"
      else
        error = "Invalid size parameter 'small' for '#{rover_name.titleize}' rover";
      end
    when "medium"
      if rover_name == "perseverance"
        replace_each_photo_suffix photos, "1200.jpg", "800.jpg"
      else
        error = "Invalid size parameter 'medium' for '#{rover_name.titleize}' rover";
      end
    when "full"
      if rover_name == "perseverance"
        replace_each_photo_suffix photos, "_1200.jpg", ".png"
      else
        error = "Invalid size parameter 'full' for '#{rover_name.titleize}' rover";
      end
    else
      error = "Unrecognized size parameter: '#{params[:size]}'";
    end

    error
  end

  private

  def replace_each_photo_suffix(photos, old_suffix, new_suffix)
    photos.map do |photo|
      replace_photo_suffix photo, old_suffix, new_suffix
    end
  end

  def replace_photo_suffix(photo, old_suffix, new_suffix)
    photo[:img_src] = photo[:img_src].delete_suffix(old_suffix) + new_suffix
  end
end
