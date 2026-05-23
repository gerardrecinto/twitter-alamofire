# Twitter (Alamofire)

![Swift](https://img.shields.io/badge/Swift-3%2B-F05138?logo=swift&logoColor=white)
![iOS 9+](https://img.shields.io/badge/iOS-9%2B-000000?logo=apple&logoColor=white)
![Alamofire](https://img.shields.io/badge/Networking-Alamofire-orange)
![AlamofireImage](https://img.shields.io/badge/Images-AlamofireImage-orange)
![OAuth](https://img.shields.io/badge/Auth-OAuthSwift%20%2B%20Keychain-1DA1F2)

![Demo](docs/assets/demo2.gif)

> Twitter client rebuilt on Alamofire's `SessionManager` with OAuthSwift handling the OAuth 1.0a flow and KeychainAccess persisting tokens securely — replacing AFNetworking and BDBOAuth1Manager with a fully Swift networking stack.

## Features

- **Alamofire SessionManager subclass:** `APIManager` extends `SessionManager` and assigns `oauthManager.requestAdapter` to its `adapter` property, so every Alamofire `request(...)` call is signed with OAuth 1.0a credentials without manual header construction
- **OAuthSwift three-legged flow:** `oauthManager.authorize(withCallbackURL:success:failure:)` drives the full request-token to authorize to access-token exchange; the callback URL scheme `alamoTwitter://` is registered in `Info.plist` and `handle(url:)` routes the app-open event to `OAuth1Swift.handle(url:)`
- **Keychain token storage:** After login, `OAuthSwiftCredential` is serialized with `NSKeyedArchiver.archivedData` and written to `KeychainAccess` under `"twitter_credentials"`. On next launch, `APIManager.init` retrieves it and restores `oauthManager.client.credential` so the user stays authenticated without re-authorizing
- **Alamofire response chaining:** `getHomeTimeLine` issues `request(url, method: .get).validate().responseJSON { ... }`, using the `Result` enum's `.success`/`.failure` switch to handle both network errors and JSON parse failures in one closure
- **Timeline disk cache:** `getHomeTimeLine` first checks `UserDefaults` for a `NSKeyedArchiver`-archived array under `"hometimeline_tweets"`, returning cached data to avoid hitting the API rate limit; on a cache miss it fetches from `1.1/statuses/home_timeline.json` and writes the result back
- **AlamofireImage profile photos:** `TweetCell` loads avatar images with `profileButton.af_setImage(withURL:)`, which routes through AlamofireImage's `ImageDownloader` with built-in `AutoPurgingImageCache`
- **`flatMap` tweet deserialization:** The response `[[String: Any]]` is converted to `[Tweet]` with `tweetDictionaries.flatMap({ Tweet(dictionary: $0) })`, discarding malformed entries without crashing
- **Compose flow via storyboard segue:** Tapping the compose button in `TimelineViewController` performs the `"composeIdentifier"` segue; the cancel button triggers `"cancelIdentifier"` to unwind back

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift 3 |
| UI | UIKit, Auto Layout, UITableViewAutomaticDimension |
| Networking | Alamofire (SessionManager), OAuthSwiftAlamofire (RequestAdapter) |
| Auth | OAuthSwift (OAuth1Swift), KeychainAccess |
| Image Loading | AlamofireImage 3.x (`af_setImage(withURL:)`, `AutoPurgingImageCache`) |
| API | Twitter API v1.1 |
| Dependencies | CocoaPods |

## Architecture

`APIManager` is a singleton `SessionManager` subclass that owns the `OAuth1Swift` instance and all Twitter API methods. `LoginViewController` calls `APIManager.shared.login`, which hands off to OAuthSwift for the browser-based auth flow. `TimelineViewController` calls `getHomeTimeLine` on `viewDidLoad`, stores the result in `tweets: [Tweet]`, and drives a `UITableView` with `TweetCell`. The key difference from the AFNetworking version is that OAuth signing is injected at the `RequestAdapter` level inside Alamofire rather than via a manager subclass, keeping all API methods free of auth boilerplate.

## Key Implementation

**RequestAdapter pattern vs. BDBOAuth1SessionManager:** In the AFNetworking version, OAuth signing required subclassing `BDBOAuth1SessionManager`. Here, `adapter = oauthManager.requestAdapter` plugs OAuthSwift's signing logic into Alamofire's `RequestAdapter` protocol — any `SessionManager.request(...)` call goes through `adapt(_:)` to get the `Authorization: OAuth ...` header added before the request fires.

**Keychain vs. UserDefaults for tokens:** The AFNetworking version stored the user dictionary in `UserDefaults`. This version stores the full `OAuthSwiftCredential` in the system Keychain via `KeychainAccess`, giving OS-level encryption for the OAuth token and secret.

**`responseJSON` vs. `AFHTTPRequestOperation` callbacks:** Alamofire's `.responseJSON` closure receives a typed `DataResponse<Any>` with a `Result<Any>` rather than separate success/failure blocks, making the error-handling path explicit and co-located with the success path.

## Setup

```bash
git clone https://github.com/gerardrecinto/twitter-alamofire.git
cd twitter-alamofire
pod install
open twitter_alamofire_demo.xcworkspace
```

Add your Twitter API consumer key and consumer secret to `APIManager.swift` before building.
