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
    var id: Int64 // For favoriting, retweeting & replying
    var text: String // Text content of tweet
    var favoriteCount: Int? // Update favorite count label
    var favorited: Bool? // Configure favorite button
    var retweetCount: Int // Update favorite count label
    var retweeted: Bool // Configure retweet button
    var user: User? // Contains name, screenname, etc. of tweet author
    var createdAtString: String // Display date
  var name: String?
  var screenname: String?
  var profileUrl: URL?
  //var favorited: Bool
 // var retweeted: Bool
 // var tweetId: Int
    // MARK: - Create initializer with dictionary
  init(dictionary: [String: Any]) {
        id = dictionary["id"] as! Int64
        text = dictionary["text"] as! String
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as! Int
        retweeted = dictionary["retweeted"] as! Bool

        let user = dictionary["user"] as! [String: Any]
      self.user = User(dictionary: user)
      self.name = self.user?.name


      self.screenname = self.user?.screenname as! String
      self.profileUrl = self.user?.profileUrl as! URL
     // self.tagline = self.user.tagline
      self.id = Int64(dictionary["id"] as! Int)
      self.favorited = dictionary["favorited"] as! Bool
      self.retweeted = dictionary["retweeted"] as! Bool
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String
        createdAtString = formatter.string(from: date)


    }
}

