module PhotoHelper

  def resize_photo photo, params
    rover_name = Rover.find_by( id: photo[:rover_id] )[:name].downcase
    suffix_data = lookup_suffix rover_name, params[:size]

    if !suffix_data.nil?
      replace_photo_suffix photo, suffix_data[:old_length], suffix_data[:new]
    else
      'size error'
    end
  end

  def resize_photos photos, params
    rover_name = params[:rover_id].downcase
    suffix_data = lookup_suffix rover_name, params[:size]

    if !suffix_data.nil?
      replace_each_photo_suffix photos, suffix_data[:old_length], suffix_data[:new]
    else
      'size error'
    end
  end

  private

  def replace_each_photo_suffix photos, old_suffix_length, new_suffix
    photos.map do |photo|
      replace_photo_suffix photo, old_suffix_length, new_suffix
    end
  end

  def replace_photo_suffix photo, old_suffix_length, new_suffix
    new_photo = photo.clone;
    new_photo[:img_src] = photo[:img_src][0, photo[:img_src].length - old_suffix_length] + new_suffix
    new_photo
  end

  def lookup_suffix rover_name, size
    suffix_hash = {
      :curiosity => {
        :original_length => 4, # .jpg or .JPG
        :sizes => {
          :small => '-thm.jpg',
          :medium => '-br.jpg',
          :large => '.jpg'
        }
      },
      :spirit => {
        :original_length => 7, # -BR.JPG
        :sizes => {
          :small => '-THM.jpg',
          :medium => '-BR.jpg',
          :large => '.jpg'
        }
      },
      :opportunity => {
        :original_length => 7, # -BR.JPG
        :sizes => {
          :small => '-THM.jpg',
          :medium => '-BR.jpg',
          :large => '.jpg'
        }
      },
      :perseverance => {
        :original_length => 9, # _1200.jpg
        :sizes => {
          :small => '_320.jpg',
          :medium => '_800.jpg',
          :large => '_1200.jpg',
          :full => '.png'
        }
      }
    }

    size = size || 'large'

    if suffix_hash.key?(rover_name.to_sym) && suffix_hash[rover_name.to_sym][:sizes].key?(size.to_sym) then
      {
        :old_length => suffix_hash[rover_name.to_sym][:original_length],
        :new => suffix_hash[rover_name.to_sym][:sizes][size.to_sym]
      }
    else
      nil
    end
  end
end
