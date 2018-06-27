# save_image
A simple gem to save all images from a url.

* This gem uses 'rest-client' to recieve html body of given url. 

* Then with the help of 'nokogiri' it parses this html body.

* It then saves each image as a file in your project directory.


## How to use -

* Install gem save_image

* Make a call to save_images method of SaveImage class with url as argument.

  SaveImage.save_images(url)
