//
//  LoginViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 6/26/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var username : String?
    var password : String?
    var currentTextField : UITextField?
    
    var isKeyboardPresent : Bool?
    @IBOutlet weak var topLayoutConstraint : NSLayoutConstraint!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccount() {
        
        self.isKeyboardPresent = false
        
    }
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification:NSNotification){
        
        if self.isKeyboardPresent == true {
            return
        }
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        self.topLayoutConstraint.constant -= keyboardFrame.height
        self.isKeyboardPresent = true
    }
    
    func keyboardWillHide(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        self.topLayoutConstraint.constant += keyboardFrame.height
        self.isKeyboardPresent = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currentTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            self.username = textField.text
        }else if textField.tag == 1 {
            self.password = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func login() {
        self.isKeyboardPresent = false

        self.currentTextField?.resignFirstResponder()
        
        print(self.username)
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let tabbarVC = storyBoard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
    }
    
}
