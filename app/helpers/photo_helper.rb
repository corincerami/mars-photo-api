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
    suffix_data = lookup_suffix rover_name, params[:size]

    if suffix_data.nil?
      error = "Invalid size parameter '#{params[:size]}' for '#{rover_name.titleize}' rover";
    else
      replace_photo_suffix photo, suffix_data[:old_length], suffix_data[:new]
    end

    error
  end

  def resize_photos photos, params
    error = nil;
    rover_name = params[:rover_id].downcase
    suffix_data = lookup_suffix rover_name, params[:size]

    if suffix_data.nil?
      error = "Invalid size parameter '#{params[:size]}' for '#{rover_name.titleize}' rover";
    else
      replace_each_photo_suffix photos, suffix_data[:old_length], suffix_data[:new]
    end

    error
  end

  private

  def replace_each_photo_suffix photos, old_suffix_length, new_suffix
    photos.map do |photo|
      replace_photo_suffix photo, old_suffix_length, new_suffix
    end
  end

  def replace_photo_suffix photo, old_suffix_length, new_suffix
    p old_suffix_length
    photo[:img_src] = photo[:img_src][0, photo[:img_src].length - old_suffix_length] + new_suffix
  end

  def lookup_suffix rover_name, size
    suffix_hash = {
      :curiosity => {
        :original_length => 4, # .jpg or .JPG
        :small => '-thm.jpg',
        :medium => '-br.jpg',
        :large => '.jpg'
      },
      :spirit => {
        :original_length => 7, # -BR.JPG
        :small => '-THM.jpg',
        :medium => '-BR.jpg',
        :large => '.jpg'
      },
      :opportunity => {
        :original_length => 7, # -BR.JPG
        :small => '-THM.jpg',
        :medium => '-BR.jpg',
        :large => '.jpg'
      },
      :perseverance => {
        :original_length => 9, # _1200.jpg
        :small => '_320.jpg',
        :medium => '_800.jpg',
        :large => '_1200.jpg',
        :full => '.png'
      }
    }

    if suffix_hash.key?(rover_name.to_sym) && !suffix_hash[rover_name.to_sym][size.to_sym].nil? then
      size = size || 'large'

      {
        :old_length => suffix_hash[rover_name.to_sym][:original_length],
        :new => suffix_hash[rover_name.to_sym][size.to_sym]
      }
    else
      nil
    end
  end
end