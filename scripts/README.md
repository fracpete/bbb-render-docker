# Scripts

## bbbr_convert

Wraps the call of the `bbbr_convert` script inside the docker container conveniently in a bash script
with the following options:

```
bbbr_convert -u <url> -n <name> [-v <version>] [-w <dir>] [-h]

Converts a BigBlueButton presentation into a .mp4 video.

 -h   this help
 -u   <url>
      the link to the presentation
 -n   <name>
      the name for the generated presentation file (excl ext, no spaces)
 -v   <version>
      the version of the docker image to use, default: 2021-06-10
 -w   <dir>
      the dir for temp files and the final video, default: .
```

**NB:** A dedicated work directory (`-w`) is recommended, since a lot of files will get downloaded to generate the final video.
