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
    if camera.is_a?(String)
      puts "WARNING: Camera not found. Name: #{camera}"
    else
      photo = Photo.find_or_initialize_by(sol: sol, camera: camera,
                                          img_src: link, rover: rover)
      photo.log_and_save_if_new
    end
  end

  def camera_from_json(image)
    camera_name = image['camera']['instrument']
    rover.cameras.find_by(name: camera_name) || camera_name
  end
end
