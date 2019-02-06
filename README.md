
# Streaming

Using mpd one can directly stream to the main channel:


```

audio_output {
  type            "shout"
  name            "RasPi MPD Stream"
  description     "MPD stream on Raspberry Pi"
  host            "localhost"
  port            "8000"
  mount           "/mpd"
  password        "ICECAST_SOURCE_PASSWORD"
  bitrate         "128"
  format          "44100:16:2"
  encoding        "mp3"
}


bind_to_address "0.0.0.0"
```


from here one can just use mpc to connect to the above mpd server for control of the player and have shoutcast configured for:

| | |
| - | - |
| /live | Live Stream ( djs, live events, etc.. ) |
| /stream | Fallback stream for music ( mpd on the cluster)  | 
| /motd | Final Fallback stream for emergancy notices ( test.mp3 )  | 

## Action shots

https://www.youtube.com/watch?v=JgQh0UK20t4


## Configuration

https://www.linode.com/docs/applications/media-servers/how-to-install-shoutcast-dnas-server-on-linux/

# Upgrades

- [1](https://hub.docker.com/r/vitiman/alpine-mpd/)
- [2](https://stmllr.net/blog/streaming-audio-with-mpd-and-icecast2-on-raspberry-pi/)
- [3](https://github.com/wernight/docker-mopidy)
