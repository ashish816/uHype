//
//  Extensions.swift
//  uHype
//
//  Created by Ashish Mishra on 6/26/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
}

extension UIImage {
    class func getProfPic(fid: String, completionHandler : @escaping (UIImage?, Error?) -> ()) {
        if (fid != "") {
            let imgURLString = "http://graph.facebook.com/" + fid + "/picture?type=large" //type=normal
            let imgURL = NSURL(string: imgURLString)
            
            URLSession.shared.dataTask(with: imgURL! as URL) { (data, response, erro) -> Void in
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data as Data)
                completionHandler(image, nil)
                }.resume()
        }
    }
}

