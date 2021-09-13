# bbb-render-docker
Docker image for the [BigBlueButton render](https://github.com/plugorgau/bbb-render)
tool, which allows you to convert recorded [BigBlueButton](https://bigbluebutton.org/) 
sessions into videos (e.g., `.mp4`).


## Docker

### Prerequisites

You need docker installed on your machine:

```commandline
sudo apt-get install docker.io
```


### Version

Uses the following hash of the bbb-render repo:

```
0644651d4c57afa329d71b7efccb24bf450fafe9
```

Timestamp: Dec 27, 2020


### Prebuilt image

* You can pull a prebuilt image from Docker Hub:

  ```commandline
  docker pull fracpete/bbb-render:latest
  ```

* Run the image as follows:

  ```commandline
  docker run -u $(id -u):$(id -g) \
      -v /local/dir:/workspace \
      -it fracpete/bbb-render:latest
  ```

  **NB:** `-v` maps a folder from the host into the container. You need this 
  for downloading the presentation and converting it into a video.


### Build local image

* You can build the image locally like this:

  ```commandline
  docker build -t bbbr .
  ```

* Once built, you can run the image with this command:

  ```commandline
  docker run -u $(id -u):$(id -g) \
      -v /local/dir:/workspace \
      -it bbbr:latest
  ```

  **NB:** `-v` maps a folder from the host into the container. You need this 
  for downloading the presentation and converting it into a video.


### Pushing local image to Docker Hub

The following steps push the image to Docker Hub (you need to adjust 
the user name, of course):

* log into Docker Hub

  ```comandline
  docker login
  ```

* tag the image for the push

  ```commandline
  docker tag \
      bbbr:latest \
      fracpete/bbb-render:latest
  ```

* push the image

  ```commandline
  docker push fracpete/bbb-render:latest
  ```

* the image is then available from:

  https://hub.docker.com/u/fracpete


### Scripts

The following scripts are available in the container:

* `bbbr_download` - wraps `download.py`
* `bbbr_make_xges` - wraps `make-xges.py`


## Example

The following steps demonstrate how to convert a presentation into an `.mp4` video:

* create a directory to house all the files, e.g.:

  ```
  $HOME/bbb
  ```

* start the docker container

  ```commandline
  docker run -u $(id -u):$(id -g) \
      -v $HOME/bbb:/workspace \
      -t bbbr:latest
  ```

* copy the link from a recorded session (copy the link from the *Presentation* button in the *Formats* column)
* download and convert the presentation into `presentation.mp4` 

  ```commandline
  bbbr_convert "PRESENTATION_LINK" presentation
  ```

The above command combines the following three commands:

* dowload the presentation

  ```commandline
  bbbr_download "PRESENTATION_LINK" /workspace
  ```

* create an xges project:

  ```commandline
  bbbr_make_xges /workspace /workspace/presentation.xges
  ```

* convert the xges project into an `.mp4` video:

  ```commandline
  ges-launch-1.0 --load /workspace/presentation.xges -o /workspace/presentation.mp4
  ```

