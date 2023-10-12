# Video Frame Capture: AVFoundation vs ffmpeg 

## Generate images

This repo contains `python` and `swift` code to generate video frame grabs using `ffmpeg` and `AVFoundation`, respectively.

### AVFoundation

#### Command

Help message:
```sh
  swift run frameGrab --help
```

Example:
```sh
  swift run frameGrab --snaps 4 -o ../images/10_secs ../vids/10_secs.mp4 0
```

### ffmpeg

Usage:
```sh
  python3 ff-snap.py <inputFile> <outDir> <numSnaps> <startMillis>
```

Example:
```sh
  python3 ff-snap.py ../vids/10_secs.mp4 ../images/10_secs 4 0
```

## Discussion

The file `vids/10_secs.mp4` is the first 10 seconds of example MBARI video. A `frameRate` of **6000/1001** is obtained using:

```sh
  ffprobe -v error \
    -select_streams v:0 \
    -of default=noprint_wrappers=1:nokey=1
    -show_entries stream=avg_frame_rate \
    vids/10_secs.mp4
```

#### Images

Note: The following comparisons use images in `image/10_secs/`

Comparing the `ffmpeg` images, the first three frame advances are:
```
    ff_10_secs_0_.jpg -> ff_10_secs_1_.jpg
    ff_10_secs_16_.jpg -> ff_10_secs_17_.jpg
    ff_10_secs_33_.jpg -> ff_10_secs_34_.jpg
```    

Comparing `AVFoundation` images, the first three frame advances are:

```
    av_10_secs_16_.png -> av_10_secs_17_.png
    av_10_secs_33_.png -> av_10_secs_34_.png
    av_10_secs_50_.png -> av_10_secs_51_.png

```

This one-off frame timing continues through the video:

```
    ff_10_secs_6139_.jpg -> ff_10_secs_6140_.jpg
    av_10_secs_6139_.png -> av_10_secs_6140_.png
```

with `ff_10_secs_6139_.jpg` being the same as `av_10_secs_6140_.png`


The `ffmpeg` frame advance going from `0` to `1` millisecond seems peculiar to me.


    
    
