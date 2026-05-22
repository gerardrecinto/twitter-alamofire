# Twitter (Alamofire)

![Swift](https://img.shields.io/badge/Swift-3%2B-F05138?logo=swift&logoColor=white)
![iOS 9+](https://img.shields.io/badge/iOS-9%2B-000000?logo=apple&logoColor=white)
![Alamofire](https://img.shields.io/badge/Networking-Alamofire-orange)
![OAuth](https://img.shields.io/badge/Auth-OAuth%201.0a-gray)

![Demo](docs/assets/demo2.gif)

iOS Twitter client built with Alamofire and OAuth 1.0a. A second pass at the Twitter client using Alamofire for all networking instead of raw URLSession.

## Features

- OAuth login with persistent session across app launches
- Home timeline showing the 20 most recent tweets with pull-to-refresh
- Compose new tweets
- Retweet and favorite actions from the tweet cell
- Adaptive Auto Layout for all iPhone sizes

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift |
| UI | UIKit, Auto Layout |
| Networking | Twitter API v1.1, Alamofire, OAuth 1.0a |
| Dependencies | CocoaPods |

## Setup

```bash
git clone https://github.com/gerardrecinto/twitter-alamofire.git
cd twitter-alamofire
pod install
open twitter_alamofire_demo.xcworkspace
```

Add your Twitter API consumer key and secret before building.
