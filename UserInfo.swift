//
//  UserInfo.swift
//  uHype
//
//  Created by Ashish Mishra on 7/4/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    
    static let sharedInstance = UserInfo()

    var firstname : String?
    var lastName : String?
    var emailId : String?
    var password : String?
    var fbId : String?
}
