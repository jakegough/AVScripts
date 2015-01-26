# AVScripts

Common scripts I use to convert videos for mobile devices.

## Tools Used
- [Handbrake](https://handbrake.fr/downloads.php) - End-to-end H264 encoder
- [FFmpeg](https://www.ffmpeg.org/download.html) - Swiss army knife of video encoders, probably the most popular for scripting
- [MakeMKV](http://www.makemkv.com/download/) - Extract raw mpeg video from a DVD or BluRay
- [Nero AAC Codec](http://www.nero.com/enu/company/about-nero/nero-aac-codec.php) - Easy to use (at least for scripting), free AAC encoder
- [WaveGain](http://www.rarewares.org/others.php#wavegain) - Normalize audio track volume (not to be confused with DRC)

### BYOS (Bring Your Own Software)

Licensing gets complicated and I don't want to risk getting sued by redistributing any of the above tools. So for these scripts to work, you'll need to download them yourself.

#### Handbrake & MakeMKV:

Just install Handbrake and MakeMKV normally.  The script should find them in their default install locations.

#### Command-Line Utilities (FFmpeg, WaveGain, NeroAAC):

Throw them in `.\bin` (or anywhere else in your found in your `PATH`.)  

For example:

- `C:\sandbox\AVScripts\` - AVScripts root
- `C:\sandbox\AVScripts\export-divx-car.cmd` - Example full script path  
- `C:\sandbox\AVScripts\bin\ffmpeg.exe`
- `C:\sandbox\AVScripts\bin\WaveGain.exe`
- `C:\sandbox\AVScripts\bin\neroAacEnc.exe`

## Form & Function

These scripts will resize and encode the video appropriate to the chosen resolution.  I also made them to normalize the audio track so you don't have to turn the volume to max just for one video, only to be ear-blasted when you pick another video.

I usually rip the disc to my hard drive as an ISO.  Then I drag the `.iso` onto  `.\makemkv\makemkv.extract-title.cmd`.  Then I drag the `.mkv` containing the content I want onto the DIVX or x264 script of my choice.

## Drag-N-Drop

Just pick your resolution and drag your video onto the appropriate script.

The process will create the resulting file (and create some temp files) in the location of the source video.  If you're sourcing them from across a network (like from a NAS), then it's faster and easier to copy them locally first.  If you feel like being a scripting ninja, then you can also set `WORKING_FOLDER` and `TEMP_FOLDER` environment variables before calling the script.

### DIVX

When encoding DIVX with FFmpeg, a video quality setting of 3-5 is recommended.  The lower the number the higher the quality.  In these scripts ___HQ___ is video quality 4 while the default/standard quality is 5.

I have a Nissan with the "Infotainment" package that will play DIVX videos from a USB drive.  Apparently, back in 2011, H.264 wasn't adopted widely enough to make it inside my dashboard.  Oh, and XVID support is spotty at best, and for that you still have to hack the fourcc tag.  So I abandoned that whole track.

For the little 7" LCD in my car, I get by with a 360p resolution and encode most things in HQ.  But when I have a video that's excessively long, I encode it with standard quality.  (For example, _Pirates of the Caribbean II- Dead Man's Chest (2006)_ would cut out close to the end if the file size was over 1GB.

- `export-divx-car.cmd`
- `export-divx-car-HQ.cmd`

And if you need DIVX for a DVD player or something, I have a few more resolutions covered:

- `export-divx-240p.cmd`
- `export-divx-240p-HQ.cmd`
- `export-divx-360p.cmd`
- `export-divx-360p-HQ.cmd`
- `export-divx-480p.cmd`
- `export-divx-480p-HQ.cmd`
- `export-divx-720p.cmd`
- `export-divx-720p-HQ.cmd`

### x264

Interestingly, x264 requires a different CRF setting to produce the same quality at varying resolutions.  So for 480p, standard quality CRF is 23 but for 1080p standard quality CRF is 28.

In this set of scripts, use standard quality for full-frame resolutions like `1920x1080`, `1280x720`, or `720x480`.  Use ___HQ___ for less-than-full-frame 'black bar' resolutions like `1920x808`, `1280x536` or even  `640x480` 4x3 content.

- `export-x264-240p.cmd`
- `export-x264-240p-HQ.cmd`
- `export-x264-360p.cmd`
- `export-x264-360p-HQ.cmd`
- `export-x264-480p.cmd`
- `export-x264-480p-HQ.cmd`
- `export-x264-720p.cmd`
- `export-x264-720p-HQ.cmd`
- `export-x264-1080p.cmd`
- `export-x264-1080p-HQ.cmd`

## Scripting

You can also use the scripts as part of larger scripts.  You can either set the appropriate environment variables, or just pass a video file in as an argument.
