[![Build Status](https://travis-ci.org/chrisccerami/mars-photo-api.svg)](https://travis-ci.org/chrisccerami/mars-photo-api)[![Code Climate](https://codeclimate.com/github/chrisccerami/mars-photo-api/badges/gpa.svg)](https://codeclimate.com/github/chrisccerami/mars-photo-api)[![Test Coverage](https://codeclimate.com/github/chrisccerami/mars-photo-api/badges/coverage.svg)](https://codeclimate.com/github/chrisccerami/mars-photo-api/coverage)

# Mars Rover Photo API

This API is designed to collect image data gathered by NASA's Curiosity, Opportunity, and Spirit rovers on Mars and make it more easily available to other developers, educators, and citizen scientists.

This version is considered pre-release, and may change frequently until 1.0.0 is released.

## Photo Attributes

Each rover has its own set of photos stored in the database, which can be queried separately. There are several possible queries that can be made against the API. Photos are organized by the sol (Martian rotation or day) on which they were taken, counting up from the rover's landing date. A photo taken on Curiosity's 1000th Martian sol exploring Mars, for example, will have a sol attribute of 1000. If instead you prefer to search by the Earth date on which a photo was taken, you can do that too.

Along with querying by date, results can also be filtered by which camera with which it was taken. Each camera has a unique function and perspective, and they are named as follows:

### Curiosity's Cameras

  Abbreviation | Camera
  ------------ | ------------------------------
   FHAZ        |  Front Hazard Avoidance Camera
   RHAZ        |  Rear Hazard Avoidance Camera
   MAST        |  Mast Camera
   CHEMCAM     |  Chemistry and Camera Complex
   MAHLI       |  Mars Hand Lens Imager
   MARDI       |  Mars Descent Imager
   NAVCAM      |  Navigation Camera

### Opportunity and Spirit's Cameras

  Abbreviation | Camera
  ------------ | -----------------------------
    FHAZ       |  Front Hazard Avoidance Camera
    RHAZ       |  Rear Hazard Avoidance Camera
    PANCAM     |  Panoramic Camera
    NAVCAM     |  Navigation Camera
    MINITES    |  Miniature Thermal Emission Spectrometer (Mini-TES)

## Querying the API

The API can be queried in the following format:

#### Queries by Martian sol:

Queries by sol can range from 0, which is the date of landing, up to the current maximum in the database. The current max sol can be found at http://mars-curiosity-api.herokuapp.com at present.

http://mars-curiosity-api.herokuapp.com/api/v1/rovers/curiosity/photos?sol=1000

#### Querying by Earth date:

Dates should be formatted as 'yyyy-mm-dd'. The earliest date available is the date of landing for each rover.

http://mars-curiosity-api.herokuapp.com/api/v1/rovers/curiosity/photos?earth_date=2015-6-3

#### Filtering Queries by Camera:

The camera parameter is not case sensitive, but must be one of the camera abbreviations listed in the table above for the respective rover.

http://mars-curiosity-api.herokuapp.com/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz

http://mars-curiosity-api.herokuapp.com/api/v1/rovers/opportunity/photos?earth_date=2015-6-3&camera=pancam


The database will be updated regularly with the latest photos from the red planet.

## Contributing

If you would like to contribute to Mars Rover Photo API, feel free to create a pull request. If you'd like to contact me, you can reach me at chrisccerami@gmail.com or on Twitter @chrisccerami.

1. Fork it ( https://github.com/chrisccerami/mars-curiosity-api/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
