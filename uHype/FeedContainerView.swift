//
//  FeedContainerView.swift
//  uHype
//
//  Created by Ashish Mishra on 7/24/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class FeedContainerView: UIView {

    var containsImage : Bool = true
    
    override func layoutSubviews() {
        
        if containsImage {
            
            var imageView = UIImageView(image : UIImage(named : "wall"))
            imageView.frame = self.frame
            self.addSubview(imageView)
            
        }else {
            
        }
        
    }

    
    

}
