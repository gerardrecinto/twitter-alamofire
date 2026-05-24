# X iOS (Alamofire)

![Swift](https://img.shields.io/badge/Swift-6.0-F05138?logo=swift&logoColor=white)
![iOS 16+](https://img.shields.io/badge/iOS-16%2B-000000?logo=apple&logoColor=white)
![Alamofire](https://img.shields.io/badge/Networking-Alamofire-orange)
![Images](https://img.shields.io/badge/Images-URLSession%20%2B%20NSCache-blue)
![API](https://img.shields.io/badge/API-X%20%28Twitter%29%20v1.1-000000)

![Demo](docs/assets/demo2.gif)

> X (formerly Twitter) client rebuilt on Alamofire's `SessionManager` with OAuthSwift handling the OAuth 1.0a flow and KeychainAccess persisting tokens securely. API v1.1 is deprecated as of March 2023 — app uses mock data for portfolio demonstration.

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift 6.0 |
| UI | UIKit, Auto Layout, UITableView.automaticDimension |
| Networking | Alamofire (SessionManager), OAuthSwiftAlamofire (RequestAdapter) |
| Auth | OAuthSwift (OAuth1Swift), KeychainAccess |
| Image Loading | URLSession + NSCache |
| API | X (Twitter) API v1.1 — mock data (deprecated March 2023) |
| Dependencies | CocoaPods |

## Architecture

`APIManager` is a singleton `SessionManager` subclass that owns the `OAuth1Swift` instance and all X API methods. `LoginViewController` calls `APIManager.shared.login`, which hands off to OAuthSwift for the browser-based auth flow. `TimelineViewController` calls `getHomeTimeLine` on `viewDidLoad`, stores the result in `tweets: [Tweet]`, and drives a `UITableView` with `TweetCell`.
