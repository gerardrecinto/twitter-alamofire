# Twitter Demo

An iOS Twitter client built with Swift, UIKit, and Alamofire, integrating the Twitter API v1.1 via OAuth 1.0a.

## Features

- OAuth login with persistent session across app launches
- Home timeline showing the 20 most recent tweets
- Pull-to-refresh on the timeline
- Compose new tweets
- Retweet and favorite actions from the tweet cell
- Profile picture, username, and timestamp on each tweet
- Adaptive Auto Layout for all iPhone sizes and orientations

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift |
| UI | UIKit, Auto Layout |
| Networking | Twitter API v1.1, Alamofire, OAuth 1.0a |
| Dependencies | CocoaPods |

## Setup

```bash
git clone https://github.com/gerardrecinto/TwitterDemo2.git
cd TwitterDemo2
pod install
open twitter_alamofire_demo.xcworkspace
```

Add your Twitter API consumer key and secret before building.
