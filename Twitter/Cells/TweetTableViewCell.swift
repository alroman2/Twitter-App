//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Alex Roman on 7/22/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit
import AlamofireImage
class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
   
    var t: Tweet! {
        didSet{
            nameLabel.text = t?.author ?? "user"
            tweetTextLabel.text = t?.text ?? "text"
            let url = URL(string: t.authorProfileImageUrl )
            profileImageView.af_setImage(withURL: url!)
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
