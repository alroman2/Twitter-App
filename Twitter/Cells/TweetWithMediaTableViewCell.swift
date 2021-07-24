//
//  TweetWithMediaTableViewCell.swift
//  Twitter
//
//  Created by Alex Roman on 7/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetWithMediaTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    
    var t: Tweet! {
        didSet{
            nameLabel.text = t?.author ?? "user"
            bodyTextLabel.text = t?.text ?? "text"
            let url = URL(string: t.authorProfileImageUrl )
            profileImageView.isHidden = false
            profileImageView.af_setImage(withURL: url!)
            let mediaUrl = URL(string: t.media!)
            mediaImageView.af_setImage(withURL: mediaUrl!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
