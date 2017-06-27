//
//  LoginViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 6/26/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccount() {
        
        
        
    }
    
    @IBAction func login() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let tabbarVC = storyBoard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
