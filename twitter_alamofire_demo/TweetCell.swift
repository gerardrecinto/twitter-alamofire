//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TweetCell: UITableViewCell {

  @IBOutlet weak var profileButton: UIImageView!
  @IBOutlet weak var tweetTextLabel: UILabel!
  //@IBOutlet weak var profileButton: UIButton!
  @IBOutlet weak var authorButton: UILabel!
  @IBOutlet weak var screennameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var replyButton: UIButton!
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var messageButton: UIButton!
  let day = Int(24 * 3600)
  let minute = Int(60)
  let hour = Int(3600)
  var rtCount: Int = 0
  var rtCountString: String = ""
  var didRt = false
  var likeCount: Int = 0
  var likeCountString: String = ""
  var didLike = false
  var timeDiff: Int = 0
  var timeString: String = ""
  //var user: User!
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
          authorButton.text = tweet.name as? String
          screennameLabel.text = "@" + (tweet.screenname as? String)!
         // dateLabel.text = String(describing: tweet.timestamp)

       /*   timeDiff = Int(Date().timeIntervalSince(tweet.createdAtString as! Date))
          if timeDiff < minute {
            timeString = String("less than a minute ago")
          }
          else if timeDiff < hour {
            timeDiff = timeDiff/minute
            timeString = String(timeDiff) + "m"
          }
          else if timeDiff < day {
            timeDiff = timeDiff/hour
            timeString = String(timeDiff) + "h"
          }
          else {
            timeDiff = timeDiff/day
            timeString = String(timeDiff) + " days ago"
          }*/

          dateLabel.text = timeString

          let replyImage = UIImage(named: "reply-icon")
          replyButton.setImage(replyImage, for: .normal)

          if tweet.retweeted == false {
            let retweetImage = UIImage(named: "retweet-icon")
            retweetButton.setImage(retweetImage, for: .normal)
            didRt = false
          }
          else {
            let retweetImage = UIImage(named: "retweet-icon-green")
            retweetButton.setImage(retweetImage, for: .normal)
            didRt = true
          }

          if tweet.favorited == false {
            let likeImage = UIImage(named: "favor-icon")
            likeButton.setImage(likeImage, for: .normal)
            didLike = false
          }
          else {
            let likeImage = UIImage(named: "favor-icon-red")
            likeButton.setImage(likeImage, for: .normal)
            didLike = true
          }

          likeCount = tweet.favoriteCount!
          rtCount = tweet.retweetCount
          setButtonCount()

        //  profileButton.af_setImage(for: .normal, url: tweet.profileUrl!)
          profileButton.af_setImage(withURL: tweet.profileUrl!)
         // myButton.imageView?.contentMode = .scaleAspectFit
      //    profileButton.imageView?.contentMode = .scaleAspectFill
        //  profileButton.imageView?.updateConstraintsIfNeeded()
        }
    }

  @IBAction func onLike(_ sender: Any) {
    if didLike{
      likeCount = likeCount - 1
    }
    else {
      likeCount = likeCount + 1
    }
    didLike = !didLike
    setButtonCount()
  }
  @IBAction func onRetweet(_ sender: Any) {
    if didRt {
      rtCount -= 1
    }
    else {
      rtCount += 1
    }
    didRt = !didRt
    setButtonCount()
  }
  override func awakeFromNib() {
        super.awakeFromNib()
        authorButton.preferredMaxLayoutWidth = authorButton.frame.size.width// Initialization code
    }
  override func layoutSubviews() {
    super.layoutSubviews()
    authorButton.preferredMaxLayoutWidth = authorButton.frame.size.width// Initialization code

  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func setButtonCount() {
    if likeCount < 1000 {
      likeCountString = String(likeCount)
    }
    else {
      likeCountString = String((likeCount/1000)) + "K"
    }

    likeButton.setTitle(likeCountString, for: .normal)

    if rtCount < 1000 {
      rtCountString = String(rtCount)
    }
    else {
      rtCountString = String((rtCount/1000)) + "K"
    }
    retweetButton.setTitle(rtCountString, for: .normal)
  }


}
