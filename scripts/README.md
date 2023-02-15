# Scripts

## bbbr_convert

Wraps the call of the [bbbr_convert](../bbbr_convert) script inside the docker container conveniently in a bash script
with the following options:

```
bbbr_convert -u <url> -n <name> [-i <image>] [-v <version>] [-w <dir>] [-s <time>] [-e <time>] [-W <width>] [-H <height>] [-c <perc>] [-a] [-S] [-h]

Converts a BigBlueButton presentation into a .mp4 video.

 -h   this help
 -u   <url>
      the link to the presentation
 -n   <name>
      the name for the generated presentation file (excl ext, no spaces)
 -i   <image>
      the docker image to use, default: fracpete/bbb-render
 -v   <version>
      the version of the docker image to use, default: 2021-06-10
 -w   <dir>
      the dir for temp files and the final video, default: .
 -s   <time>
      the start time
 -e   <time>
      the end time
 -W   <width>
      the width of the presentation, default: 1920
 -H   <height>
      the height of the presentation, default: 1080
 -c   <perc>
      the percentage of the screen to reserve for the webcam (0-100), default: 20
 -S   stretch the webcam by 33% to correct aspect ratio
 -a   add annotations like whiteboard and red dot cursor

Some accepted TIME formats:
- ss seconds (example: 1500 or 1500.3)
- mm:ss minutes and seconds
- hh:mm:ss hours minutes and seconds
- dd:hh:mm:ss days, hours, minutes and seconds
```

**NB:** A dedicated work directory (`-w`) is recommended, since a lot of files will get downloaded to generate the final video.
