# Mars Curiosity Photo API

This API is designed to collect image data gathered by NASA's Curiosity rover on Mars and make it more easily available to other developers, educators, and citizen scientists.

Photos can be found by both the sol on which they were taken by Curiosity, and by the camera with which they were taken. There are seven cameras aboard Curiosity. The Front Hazard Avoidance camera (FHAZ), Read Hazard Avoidance camera (FHAZ), Chemistry and Camera complex (CHEMCAM), Navigation cameras (NAVCAM), Mast Camera (MASTCAM), Mars Hand Lens Imager (MAHLI), and the Mars Descent Imager (MARDI).

The API can be queried in the following format, http://mars-curiosity-api.herokuapp.com/photos.json/?sol=<MARTIAN_DATE>&camera=<CAMERA_NAME>, where MARTIAN_DATE should be replaced by a number between 1 and the current number of sols (Martian solar cycles) Curiosity has been on Mars, and CAMERA_NAME can be replaced with the name of one of the seven onboard camera systems.

The database will be updated regularly with the latest photos from the red planet.
