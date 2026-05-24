//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class Tweet {

    // MARK: Properties
    var id: Int64
    var text: String
    var favoriteCount: Int?
    var favorited: Bool?
    var retweetCount: Int
    var retweeted: Bool
    var user: User?
    var createdAtString: String
    var name: String?
    var screenname: String?
    var profileUrl: URL?

    // MARK: - Create initializer with dictionary
    init?(dictionary: [String: Any]) {
        // Support both Int and Int64 from JSON
        if let idInt64 = dictionary["id"] as? Int64 {
            id = idInt64
        } else if let idInt = dictionary["id"] as? Int {
            id = Int64(idInt)
        } else {
            return nil
        }

        guard let tweetText = dictionary["text"] as? String else { return nil }
        text = tweetText

        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as? Int ?? 0
        retweeted = dictionary["retweeted"] as? Bool ?? false

        if let userDict = dictionary["user"] as? [String: Any] {
            let userObj = User(dictionary: userDict)
            self.user = userObj
            self.name = userObj?.name
            self.screenname = userObj?.screenname
            self.profileUrl = userObj?.profileUrl
        }

        let createdAtOriginalString = dictionary["created_at"] as? String ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        if let date = formatter.date(from: createdAtOriginalString) {
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            createdAtString = formatter.string(from: date)
        } else {
            createdAtString = createdAtOriginalString
        }
    }
}
