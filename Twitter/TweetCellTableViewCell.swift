//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Alexander Roman Montiel on 11/6/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited:Bool = false;
    var retweeted:Bool = false;
    var tweetID:Int = -1;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onRetweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if toBeRetweeted{
            TwitterAPICaller.client?.favoritedTweet(tweetID: tweetID, success: {
                self.setRetweet(_isRetweeted: true)
            }, failure: { (error) in
                print("Retweet did not succeed\(error)")
            })
        }
        else{
            TwitterAPICaller.client?.favoritedTweet(tweetID: tweetID, success: {
                self.setFavorited(_isFavorited: false)
            }, failure: { (error) in
                print("Unretweet did not succeed \(error)")
            })
        }
    }
    
    func setRetweet(_isRetweeted: Bool){
        retweeted = _isRetweeted;
        if retweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func onFav(_ sender: Any) {
        let toBeFavorited = !favorited
        if toBeFavorited {
            TwitterAPICaller.client?.favoritedTweet(tweetID: tweetID, success: {
                self.setFavorited(_isFavorited: true)
            }, failure: { (error) in
                print("Favorite did not succed \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorited(_isFavorited: false)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
    func setFavorited(_isFavorited:Bool) {
        favorited = _isFavorited
        if (favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
}
