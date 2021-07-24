//
//  Tweet.swift
//  Twitter
//
//  Created by Alex Roman on 7/22/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import Foundation
import UIKit

class Tweet: NSObject {
    let author: String
    let authorProfileImageUrl: String
    let text: String
    let media: String?
    
    convenience init(author: String, text: String, imageUrl: String) {
        self.init(author: author,text: text, imageUrl: imageUrl, media: nil)
        
    }
    
    init(author: String, text: String, imageUrl: String, media: String?) {
        self.author = author
        self.authorProfileImageUrl = imageUrl
        self.text = text
        self.media = media
        
    }
}
