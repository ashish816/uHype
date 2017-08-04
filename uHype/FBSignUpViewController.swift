//
//  FBSignUpViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 7/22/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class FBSignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var infoPassedFromFaceBookLogin : UserInfo?
    var currentTextField : UITextField?
    let pickerViewData = ["2015(Senior)", "2016(Junior)", "2017(Sophomore)", "2018(Freshman)"]
    
      @IBOutlet var userProfilePic : UIImageView!
    @IBOutlet var userWelcomeLabel : UILabel!

    
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
        self.userWelcomeLabel.text = "Welcome" + UserInfo.sharedInstance.firstname!
        
       UIImage.getProfPic(fid: UserInfo.sharedInstance.fbId!) { (image, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.userProfilePic.image? = image!
                }
            }
        }
    }
    
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 0 {
            textField.inputView = graduationPickerView
            textField.inputAccessoryView = pickerToolBar
        }
        
        self.currentTextField = textField
        return true
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
        
        self.performSegue(withIdentifier: "SignupToAgreement", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
