//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {

    var name: String?
  var screenname: String?
  var profileUrl: URL?
  var tagline: String?
  var dictionary: NSDictionary?
  var coverPhotoUrl: URL?
  var tweetsCount: Int = 0
  var followerCount: Int = 0
  var followingCount: Int = 0

  init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
      screenname = dictionary["screen_name"] as? String
      let profileUrlString = dictionary["profile_image_url_https"] as? String
      if let profileUrlString = profileUrlString{
        profileUrl = URL(string: profileUrlString)
      } else {
        profileUrl = URL(string: "")
      }
      let coverPhotoUrlString = dictionary["profile_background_image_url_https"] as? String
      if let coverPhotoUrlString = coverPhotoUrlString {
        coverPhotoUrl = URL(string: coverPhotoUrlString)
      } else {
        coverPhotoUrl = URL(string: "")
      }
      tweetsCount = dictionary["statuses_count"] as! Int
      tagline = dictionary["description"] as? String
      followerCount = dictionary["followers_count"] as! Int
      followingCount = dictionary["friends_count"] as! Int
    }
}
