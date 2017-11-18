class OpportunitySpiritScraper
  require "open-uri"

  BASE_URI = "https://mars.nasa.gov/mer/gallery/all/"

  attr_reader :rover

  def initialize(rover)
    @rover = Rover.find_by(name: rover)
  end

  SOL_SELECT_CSS_PATHS = [
    "#Engineering_Cameras_Front_Hazcam",
    "#Engineering_Cameras_Rear_Hazcam",
    "#Engineering_Cameras_Navigation_Camera",
    "#Science_Cameras_Panoramic_Camera",
    "#Science_Cameras_Microscopic_Imager"
  ]

  CAMERAS = {
    f: "FHAZ",
    r: "RHAZ",
    n: "NAVCAM",
    p: "PANCAM",
    m: "MINITES",
    e: "ENTRY"
  }

  def scrape
    collect_sol_paths
  end

  def main_page
    rover_html = "#{rover.name.downcase}.html"
    Nokogiri::HTML(open(BASE_URI + rover_html))
  end

  def sol_paths
    paths = Array.new
    SOL_SELECT_CSS_PATHS.each do |s|
      select = main_page.css(s).first
      select.css("option").each do |option|
        paths << option.attributes["value"].value
      end
    end
    paths
  end

  def collect_sol_paths
    sol_paths.each do |path|
      regex = /(?<camera>\w)(?<sol>\d+)/.match(path)
      sol = regex[:sol]
      camera_name = CAMERAS[regex[:camera].to_sym]
      camera = rover.cameras.find_by(name: camera_name)
      photos = rover.photos.where(sol: sol, camera: camera)
      if !photos.any?
        begin
          collect_image_paths(path)
        rescue => e
          Rails.logger.info e
          Rails.logger.info path
          next
        end
      end
    end
  end

  def collect_image_paths(sol_path)
    photos_page = Nokogiri::HTML(open(BASE_URI + sol_path))
    photo_links = photos_page.css("tr[bgcolor='#F4F4E9']").map { |p| p.css("a") }
    photo_links.each do |links|
      links.each do |link|
        create_photos(link)
      end
    end
  end

  def create_photos(link)
    path = link.attributes["href"].value
    reg = /(?<early_path>\d\/(?<camera_name>\w)\/(?<sol>\d+)\/)\S+/.match(path)
    camera = rover.cameras.find_by(name: CAMERAS[reg[:camera_name].to_sym])
    photo_page = Nokogiri::HTML(open(BASE_URI + path))
    src = build_src(reg[:early_path], photo_page)
    photo = Photo.find_or_initialize_by(sol: reg[:sol].to_i, camera: camera,
                                    img_src: src, rover: rover)
    photo.log_and_save_if_new
  end

  def build_src(early_path, photo_page)
    BASE_URI +
    early_path +
    photo_page.css("table[width='500'] img").first.attributes["src"].value
  end
end
