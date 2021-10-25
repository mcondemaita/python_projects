//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Maria  Condemaita on 10/10/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    
    var tweetArray = [NSDictionary]()
    var numberofTweet: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets() // Load APIS
    
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged); tableView.refreshControl = myRefreshControl
    }
    // Call APIs to loadtweets
    @objc func loadTweets(){
        
        numberofTweet = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberofTweet] // follow the twitter API caller, and call any parameter that ins on the .json file
    
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success:
        { (tweets: [NSDictionary]) in   //results are the result from our APIs
            
            self.tweetArray.removeAll() // empty a linst to create a new list
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData() // relod the data with that contect
            self.myRefreshControl.endRefreshing()
            
        }, failure: {(Error) in
            print("Could not retreive tweets!, oh no")
        })
}

    // load more tweets
    
    func loadMoreTweets(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberofTweet = numberofTweet + 20
        
        let myParams = ["count": numberofTweet] // follow the twitter API caller, and call any parameter that ins on the .json file
    
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success:
        { (tweets: [NSDictionary]) in   //results are the result from our APIs
            
            self.tweetArray.removeAll() // empty a linst to create a new list
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData() // relod the data with that contect
            self.myRefreshControl.endRefreshing()
            
        }, failure: {(Error) in
            print("Could not retreive tweets!, oh no")
        })

    }
    
    override func tableView(_ tableView:UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLonggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.UserNameLabel.text = user["name"] as? String
        cell.TweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.ProfileImageView.image = UIImage(data: imageData)
        }
        return cell
    }


    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count // depending on the API info
    }
}
