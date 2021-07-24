//
//  HomeViewController.swift
//  Twitter
//
//  Created by Alex Roman on 7/22/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    let defaults = UserDefaults.standard
    var timeline = [Tweet]()
    let refreshControl = UIRefreshControl()
    var tweetCount: Int!
    @IBOutlet weak var timeLineTableView: UITableView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        getTimelineData()
        
        refreshControl.addTarget(self, action: #selector(getTimelineData), for: .valueChanged)
        timeLineTableView.refreshControl = refreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
            styleNavBar()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        defaults.setValue(false, forKey: "isAuthenticated")
        performSegue(withIdentifier: "logoutToAuth", sender: self)
    }
    
    func styleNavBar() {
        let navBar = self.navigationController?.navigationBar
    
        let navBarImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        navBarImageView.contentMode = .scaleAspectFit
        let twitterImage = UIImage(named: "TwitterLogoBlue" )
        navBarImageView.image = twitterImage
        navigationItem.titleView = navBarImageView
    }
    
    @objc func getTimelineData(){
        tweetCount = 20
        let reqUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let reqParams = ["count": tweetCount]
        TwitterAPICaller.client?.getDictionariesRequest(url: reqUrl, parameters: reqParams, success: { (tweets: [NSDictionary]) in
            var i = 0
            self.timeline.removeAll()
            for tweet in tweets {
                var postMediaUrl:String? = nil
                let user = tweet["user"] as! NSDictionary
                let name = user["name"] as? String
                let text = tweet["text"] as? String
                let imageUrl = user["profile_image_url_https"] as? String ?? ""
                if let entities = tweet["entities"] as? NSDictionary {
                    if let media = entities["media"] as? NSArray {
                        if let mediaUrl = (media[0] as? NSDictionary)?["media_url_https"] {
                            print(mediaUrl)
                            postMediaUrl = mediaUrl as? String
                        }
                    } else {print("media not found")}
                } else { print("failure")}
                
                let tempTweet = Tweet(author: name!, text: text!, imageUrl: imageUrl, media: postMediaUrl)
                self.timeline.append(tempTweet)
                postMediaUrl = nil
                 i += 1
                self.refreshControl.endRefreshing()
            }
    
            self.timeLineTableView.reloadData()
            
        }, failure: { Error in
            let alert = UIAlertController(title: "Error Retrieving Timeline", message: Error.localizedDescription, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        })
        
    }
    
    func paginate(){
        let reqUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let newTweetCount = tweetCount + 20
        
        let reqParams = ["count":newTweetCount]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: reqUrl, parameters: reqParams, success: { (tweets: [NSDictionary]) in
            self.timeline.removeAll()
            for tweet in tweets {
                var postMediaUrl:String? = nil
                let user = tweet["user"] as! NSDictionary
                let name = user["name"] as? String
                let text = tweet["text"] as? String
                let imageUrl = user["profile_image_url_https"] as? String ?? ""
                if let entities = tweet["entities"] as? NSDictionary {
                    if let media = entities["media"] as? NSArray {
                        if let mediaUrl = (media[0] as? NSDictionary)?["media_url_https"] {
                            print(mediaUrl)
                            postMediaUrl = mediaUrl as? String
                        }
                    } else {print("media not found")}
                } else { print("failure")}
                
                let tempTweet = Tweet(author: name!, text: text!, imageUrl: imageUrl, media: postMediaUrl)
                self.timeline.append(tempTweet)
                postMediaUrl = nil
            }
    
            self.timeLineTableView.reloadData()
            
        }, failure: { Error in
            let alert = UIAlertController(title: "Error Retrieving Timeline", message: Error.localizedDescription, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        })
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeline.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row + 1 == timeline.count{
            paginate()
        }
        
        if (timeline[indexPath.row].media == nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
           
            
            cell.t = timeline[indexPath.row]
            
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetWithMediaTableViewCell", for: indexPath) as! TweetWithMediaTableViewCell
           
            
            cell.t = timeline[indexPath.row]
            
            
            return cell
        }
    }
}
