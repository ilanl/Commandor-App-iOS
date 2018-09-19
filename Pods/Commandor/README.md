An example of feed for customizing actions locally or remotely

```ruby
{
    "rules": [
        { "type": "play-media",
           "priority": [
            {
                "handler": "DefaultVideoPlayer"
            },
            {
                "handler": "YouTubeVideoPlayer"
            }]
        }
    ],
    "feed": [
        {
            "type": "play-media",
            "force-handler": "YouTubeVideoPlayer",
            "src": "https://www.youtube.com/watch?v=oQg4VCw24Qo"
        },
        {
            "type": "play-media",
            "src": "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        },
        {
            "type": "show-on-map",
            "coordinates": {
                "lat": 100,
                "lon": 34
            }
        },
        {
            "type": "open-url-scheme",
            "title": "Open Wifi",
            "background-color": "#0000FF",
            "url": {
                "app-name": "myapp",
                "query": "hello=1"
            }
        }
    ]
}

```
