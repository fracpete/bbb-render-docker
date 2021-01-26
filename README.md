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


### Build

You can build the image locally like this:

```commandline
docker build -t bbbr .
```


### Run

Once built, you can run the image with this command:

```commandline
docker run -u $(id -u):$(id -g) \
    -v /local/dir:/container/dir \
    -it bbbr:latest
```

**NB:** `-v` maps a folder from the host into the container. You need this 
for downloading the presentation and converting it into a video.


### Scripts

The following scripts are available in the container:

* `bbbr_download` - wraps `download.py`
* `bbbr_make_xges` - wraps `make-xges.py`


## Example

The following steps demonstrate how to convert a presentation into an `.mp4` video:

* start the docker container

  ```commandline
  docker run -u $(id -u):$(id -g) \
      -v /some/where:/opt/test \
      -t bbbr:latest
  ```

* copy the link from a recorded session (copy the link from the *Presentation* button in the *Formats* column)
* dowload the presentation

  ```commandline
  bbbr_download "PRESENTATION_LINK" /opt/test
  ```

* create an xges project:

  ```commandline
  bbbr_make_xges /opt/test /opt/test/test.xges
  ```

* convert the xges project into an `.mp4` video:

  ```commandline
  ges-launch-1.0 --load /opt/test/test.xges -o /opt/test/test.mp4
  ```

