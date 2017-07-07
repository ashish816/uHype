//
//  SignUpViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 6/26/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit
import Alamofire

enum SignUpTextFieldTag : Int {
    case username
    case email
    case fname
    case lname
    case password
}


class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var infoPassedFromFaceBookLogin : UserInfo?
    @IBOutlet var emailTF : UITextField!
    @IBOutlet var fisrtnameTF : UITextField!
    @IBOutlet var lastnameTF: UITextField!
    
    var currentTextField : UITextField?
    let pickerViewData = ["2015(Senior)", "2016(Junior)", "2017(Sophomore)", "2018(Freshman)"]
    
    var signUpDictionary = ["username" : "" ,"email" : "", "firstname" : "", "lastname": "", "graduationyear": "", "graduationlevel" : "", "password": ""];
    
   lazy var graduationPickerView : UIPickerView = {
        var pickerView = UIPickerView(frame: CGRect(x:0, y:0, width : self.view.frame.width, height : 200))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }()
    
    lazy var pickerToolBar : UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.backgroundColor = UIColor.white
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SignUpViewController.donePicker))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        emailTF.text = self.infoPassedFromFaceBookLogin?.emailId
        fisrtnameTF.text = self.infoPassedFromFaceBookLogin?.firstname
        lastnameTF.text = self.infoPassedFromFaceBookLogin?.lastName

    }
  
 // MARK: Picker View delegate methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerViewData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let titleForRow = self.pickerViewData[row]
        
        var graduationComponents = titleForRow.components(separatedBy: "(")
        let graduationYear = graduationComponents[0]
        let graduationLevel = graduationComponents[1].components(separatedBy: ")")[0]
        
        self.signUpDictionary["graduationyear"] = graduationYear
        self.signUpDictionary["graduationlevel"] = graduationLevel
        
        self.currentTextField?.text = titleForRow
    }
    
  // MARK: Test field delegate methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 4 {
            textField.inputView = graduationPickerView
            textField.inputAccessoryView = pickerToolBar
        }
        
        self.currentTextField = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == SignUpTextFieldTag.username.rawValue {
            self.signUpDictionary["username"] = textField.text
        }else if textField.tag == SignUpTextFieldTag.email.rawValue {
            self.signUpDictionary["email"] = textField.text
        }else if textField.tag == SignUpTextFieldTag.fname.rawValue {
            self.signUpDictionary["firstname"] = textField.text
        }else if textField.tag == SignUpTextFieldTag.lname.rawValue {
            self.signUpDictionary["lastname"] = textField.text
        }else if textField.tag == SignUpTextFieldTag.password.rawValue {
            self.signUpDictionary["password"] = textField.text
        }
    }
    
    func donePicker() {
        self.currentTextField?.resignFirstResponder()
    }
    
    @IBAction func goBackToLoginVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUp() {
        self.currentTextField?.resignFirstResponder()
        print(self.signUpDictionary)
        
//        let signUpParam : Parameters = ["username" : "ashish816" ,"email" : "ashish88.it@gmail.com", "firstname" : "Ashish", "lastname": "Mishra", "graduationyear": "2017", "graduationlevel" : "Freshmen", "password": "12345"];
//        let url = SERVER_PATH + "socketEmit"
//        
//        Alamofire.request(url, method: .post, parameters: signUpParam, encoding: JSONEncoding.default).response { (response) in
//            print(response)
//            
//        }
    }
}

