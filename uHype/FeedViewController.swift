//
//  FeedViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 7/16/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var feedTableViewDataSource : [FeedModel]  = [FeedModel]()
    @IBOutlet var feedTable : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...5 {
            
            var feedModel = FeedModel()
            feedModel.feedComment = "This is the comment no " + "\(i)"
            feedModel.schoolName = "Schoolname" + "\(i)" + "\n" + "\(i)" + "July 2017"
            
            self.feedTableViewDataSource.append(feedModel)
        }
        
//        self.feedTable.rowHeight = UITableViewAutomaticDimension
        
        self.feedTable.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedTableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
//        cell.feedCommentLabel.text = self.feedTableViewDataSource[indexPath.row].feedComment
        cell.schoolNameDateLabel.text = self.feedTableViewDataSource[indexPath.row].schoolName
        return cell
    }

}
