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

Note: The file `vids/10_secs.mp4` is the first 10 seconds of example MBARI video.

#### Video info

The file `vids/10_secs-frame.info` contains the frame information for the video, obtained via:

```sh
  ffprobe -show_frames 10_secs.mp4 > 10_secs-frame.info
```

Of particular note, the **info** file shows:

    1st frame: best_effort_timestamp_time=0.000000
    2nd frame: best_effort_timestamp_time=0.016683
    3rd frame: best_effort_timestamp_time=0.033367

#### Images

Note: The following comparisons use images in `image/10_secs/`

Comparing the `ffmpeg` images
```
    ff_10_secs_0_.jpg -> ff_10_secs_1_.jpg
```    

the frame advances going from `0` to `1` millisecond. That does not seem to agree with the **info** file.

Comparing `AVFoundation` images

```
    av_10_secs_0_.jpg -> av_10_secs_1_.jpg
```

there is no frame advance. The frame does not advance until

```
    av_10_secs_16_.jpg -> av_10_secs_17_.jpg
```    

which seems to agree with the **info** file.

This one-off frame timing extends into the video. Looking at where the `ffmpeg` frame advances at 10 frames (using the **info** file), the frame advances at:

```
    ff_10_secs_166_.jpg -> ff_10_secs_167_.jpg    
```

and for `AVFoundation`, the frame advances at

```
    av_10_secs_166_.jpg -> av_10_secs_167_.jpg
```

However, `ff_10_secs_166_.jpg` is the same as `av_10_secs_167_.jpg`, that is, the frameworks disagree by one frame.




    
    
