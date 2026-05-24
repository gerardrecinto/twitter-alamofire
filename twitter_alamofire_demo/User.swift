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

    init?(dictionary: [String: Any]) {
        guard let userName = dictionary["name"] as? String else { return nil }
        name = userName
        screenname = dictionary["screen_name"] as? String

        if let profileUrlString = dictionary["profile_image_url_https"] as? String {
            profileUrl = URL(string: profileUrlString)
        }

        if let coverPhotoUrlString = dictionary["profile_background_image_url_https"] as? String {
            coverPhotoUrl = URL(string: coverPhotoUrlString)
        }

        tweetsCount = dictionary["statuses_count"] as? Int ?? 0
        tagline = dictionary["description"] as? String
        followerCount = dictionary["followers_count"] as? Int ?? 0
        followingCount = dictionary["friends_count"] as? Int ?? 0
    }
}
