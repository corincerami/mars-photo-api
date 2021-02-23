class PerseveranceScraper
  require "open-uri"
  require 'json'
  BASE_URL = "https://mars.nasa.gov/mars2020/multimedia/raw-images/"

  attr_reader :rover
  def initialize
    @rover = Rover.find_by(name: "Perseverance")
  end

  def scrape
    create_photos
  end

  def collect_links
    response = (URI.open("https://mars.nasa.gov/rss/api/?feed=raw_images&category=mars2020&feedtype=json&latest=true").read)
    latest_sol_available = JSON.parse(response)["latest_sol"].to_i
    latest_sol_scraped = rover.photos.maximum(:sol).to_i
    sols_to_scrape = latest_sol_scraped..latest_sol_available
    sols_to_scrape.map { |sol|
	    "https://mars.nasa.gov/rss/api/?feed=raw_images&category=mars2020&feedtype=json&sol=#{sol}"
    }
  end

  private

  def create_photos
    collect_links.each do |url|
      scrape_photo_page(url)
    end
  end

  def scrape_photo_page(url)
    image_array = JSON.parse(URI.open(url).read)
    image_array['images'].each do |image|
      if(image['sample_type'] == 'Full')
        url = image['image_files']['large']
        create_photo(image)
      end
    end
  end

  def create_photo(image)
    sol = image['sol']
    camera = camera_from_json image
    link = image['image_files']['large']
    fail "Camera not found. Name: #{camera}" if camera.is_a?(String)
    photo = Photo.find_or_initialize_by(sol: sol, camera: camera,
                                        img_src: link, rover: rover)
    photo.log_and_save_if_new
  end

  def camera_abbreviations
    {
      erucam:  "EDL_RUCAM",
      erdcam:  "EDL_RDCAM",
      edocam:  "EDL_DDCAM",
      epu1cam: "EDL_PUCAM1",
      epu2cam: "EDL_PUCAM2",
      navlcam: "NAVCAM_LEFT",
      nacrcam: "NAVCAM_RIGHT",
      mczlcam: "MCZ_LEFT",
      mczrcam: "MCZ_RIGHT",
      fhlacam: "FRONT_HAZCAM_LEFT_A",
      fhracam: "FRONT_HAZCAM_RIGHT_A",
      fhlbcam: "FRONT_HAZCAM_LEFT_B",
      fhrbcam: "FRONT_HAZCAM_RIGHT_B",
      rhlcam:  "REAR_HAZCAM_LEFT",
      rhrcam:  "REAR_HAZCAM_RIGHT"
    }
  end

  def camera_from_json(image)
    camera_name = image['camera']['instrument']
    rover.cameras.find_by(name: camera_name) || camera_name
  end
end

