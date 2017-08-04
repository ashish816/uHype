//
//  LoginViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 6/26/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var username : String?
    var password : String?
    var currentTextField : UITextField?
    
    var isKeyboardPresent : Bool?
    @IBOutlet weak var topLayoutConstraint : NSLayoutConstraint!
    @IBOutlet weak var fbLoginButton : UIButton!
    let loginManager = LoginManager()
    var userInfo : UserInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
  
        fbLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        

    }
    
    @objc func loginButtonClicked() {
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, email "]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        let fbDetails = result as! Dictionary<String, Any>
                        
                        var user = UserInfo.sharedInstance
                        user.firstname = fbDetails["first_name"] as! String
                        user.lastName = fbDetails["last_name"] as! String
                        user.emailId = fbDetails["email"] as! String
                        user.fbId = fbDetails["id"] as! String
                        print(fbDetails)
                        self.userInfo = user
                        self.performSegue(withIdentifier: "LoginToSignUp", sender: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func createAccount() {
        
        self.isKeyboardPresent = false
        self.performSegue(withIdentifier: "LoginToSignUp", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination as! SignUpViewController
        destination.infoPassedFromFaceBookLogin = self.userInfo
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
