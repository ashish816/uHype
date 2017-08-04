//
//  UserTimeLineViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 7/4/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class UserTimeLineViewController: UIViewController {
    
    @IBOutlet var containerView : UIView!
    @IBOutlet var profileImageView : UIImageView!
    
    @IBOutlet var segmentedControl : UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for:.valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        
        print( UserInfo.sharedInstance.fbId!)
        
        UIImage.getProfPic(fid: UserInfo.sharedInstance.fbId!) { (image, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.profileImageView.image? = image!
                }
            }
        }

    }
    
    @IBAction func segmentedControlValueChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let feedVc = storyBoard.instantiateViewController(withIdentifier: "FeedViewController")
            self.addChildViewController(feedVc)
            self.containerView.addSubview(feedVc.view)
            
        }else if segment.selectedSegmentIndex == 1 {
            
        }else if segment.selectedSegmentIndex == 2{
            
        }
    }
    
}
