module PhotoHelper

  def resize_photo photo, params

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
        # WARNING: invalid size parameter for rover
        puts "WARNING: invalid size parameter for rover"
      end
    when "medium"
      if rover_name == "perseverance"
        replace_photo_suffix photo, "1200.jpg", "800.jpg"
      else
        # WARNING: invalid size parameter for rover
        puts "WARNING: invalid size parameter for rover"
      end
    when "full"
      if rover_name == "perseverance"
        replace_photo_suffix photo, "_1200.jpg", ".png"
      else
        # WARNING: invalid size parameter for rover
        puts "WARNING: invalid size parameter for rover"
      end
    else
      # WARNING: invalid size parameter
      puts "WARNING: invalid size parameter"
    end

    photo
  end

  def resize_photos photos, params

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
        # WARNING: invalid size parameter for rover
        puts "WARNING: invalid size parameter for rover"
      end
    when "medium"
      if rover_name == "perseverance"
        replace_each_photo_suffix photos, "1200.jpg", "800.jpg"
      else
        # WARNING: invalid size parameter for rover
        puts "WARNING: invalid size parameter for rover"
      end
    when "full"
      if rover_name == "perseverance"
        replace_each_photo_suffix photos, "_1200.jpg", ".png"
      else
        # WARNING: invalid size parameter for rover
        puts "WARNING: invalid size parameter for rover"
      end
    else
      # WARNING: invalid size parameter
      puts "WARNING: invalid size parameter"
    end

    photos
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
