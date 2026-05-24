# Twitter (Alamofire)

![Swift](https://img.shields.io/badge/Swift-6.0-F05138?logo=swift&logoColor=white)
![iOS 16+](https://img.shields.io/badge/iOS-16%2B-000000?logo=apple&logoColor=white)
![Alamofire](https://img.shields.io/badge/Networking-Alamofire-orange)
![Images](https://img.shields.io/badge/Images-URLSession%20%2B%20NSCache-blue)
![OAuth](https://img.shields.io/badge/Auth-OAuthSwift%20%2B%20Keychain-1DA1F2)

![Demo](docs/assets/demo2.gif)

> Twitter client rebuilt on Alamofire's `SessionManager` with OAuthSwift handling the OAuth 1.0a flow and KeychainAccess persisting tokens securely — replacing URLSession (native)| Layer | Technology |
|---|---|
| Language | Swift 6.0 |
| UI | UIKit, Auto Layout, UITableViewAutomaticDimension |
| Networking | Alamofire (SessionManager), OAuthSwiftAlamofire (RequestAdapter) |
| Auth | OAuthSwift (OAuth1Swift), KeychainAccess |
| Image Loading | URLSession + NSCache|
| API | Twitter API v1.1 |
| Dependencies | CocoaPods |

## Architecture

`APIManager` is a singleton `SessionManager` subclass that owns the `OAuth1Swift` instance and all Twitter API methods. `LoginViewController` calls `APIManager.shared.login`, which hands off to OAuthSwift for the browser-based auth flow. `TimelineViewController` calls `getHomeTimeLine` on `viewDidLoad`, stores the result in `tweets: [Tweet]`, and drives a `UITableView` with `TweetCell`. The key difference from the URLSession (native)