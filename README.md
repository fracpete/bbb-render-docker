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


### Version (for latest docker image)

Uses the following hash of the bbb-render repo:

```
e137d9d9c72fe7985e72338d4fa0a748f39e2b08
```

Timestamp: Jun 10, 2021


### Prebuilt images

The following images are available from docker hub:

```
fracpete/bbb-render:latest
fracpete/bbb-render:2021-06-10
fracpete/bbb-render:2020-12-27
```


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

* `bbbr_convert` - downloads and converts a presentation, use `-h` for a help screen
* `bbbr_download` - just downloads a presentation (wraps `download.py`)
* `bbbr_make_xges` - generates an xges project (wraps `make-xges.py`)

For launching the docker container and convert a presentation you can use this script 
(use `-h` to see all available options):

* [scripts/bbbr_convert](scripts/bbbr_convert)


## Examples

### scripts/bbbr_convert

Prerequisites:

* Download the [scripts/bbbr_convert](scripts/bbbr_convert) script
* Place the script on a directory that is in your `$PATH` environment variable 
  (e.g., `$HOME/bin` or `/usr/local/bin`)

The following steps convert a presentation into an `.mp4` video:

* If necessary, create a working directory, e.g.:

  ```
  $HOME/bbb
  ```

* Get the link from a recorded session by copying the link from the
  *Presentation* button in the *Formats* column.

* Run the following command to generate the `PRESENTATION_NAME.mp4` 
  video file in the `$HOME/bbb` directory:

  ```commandline
  bbbr_convert -u "PRESENTATION_LINK" -n "PRESENTATION_NAME" -w "$HOME/bbb"
  ```


### Docker

The following steps demonstrate how to convert a presentation into an `.mp4` video:

* Create a directory to house all the files, e.g.:

  ```
  $HOME/bbb
  ```

* Change into that directory:

  ```commandline
  cd $HOME/bbb
  ```

* Get the link from a recorded session by copying the link from the
  *Presentation* button in the *Formats* column.

* Run the `bbbr_convert` command as follows (replace `PRESENTATION_LINK` with
  the actual link and `PRESENTATION_NAME` with the name that you want for the
  .mp4 file) to download and convert the BBB presentation:

  ```commandline
  docker run -u $(id -u):$(id -g) \
      -v `pwd`:/workspace \
      -t fracpete/bbb-render:latest \
      bbbr_convert "PRESENTATION_LINK" PRESENTATION_NAME
  ```

The above command combines the following three commands:

* Dowload the presentation

  ```commandline
  bbbr_download "PRESENTATION_LINK" /workspace
  ```

* Create an xges project:

  ```commandline
  bbbr_make_xges /workspace /workspace/PRESENTATION_NAME.xges
  ```

* Convert the xges project into an `.mp4` video:

  ```commandline
  ges-launch-1.0 --load /workspace/PRESENTATION_NAME.xges -o /workspace/PRESENTATION_NAME.mp4
  ```

