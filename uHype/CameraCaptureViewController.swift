//
//  CameraCaptureViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 6/26/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit
import AVFoundation

class CameraCaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker : UIImagePickerController!
    @IBOutlet var profileImageView : UIImageView?


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func captureImage() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        // 2
        let openCamera = UIAlertAction(title: "Open Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.takePhoto()
        })
        let OpenGallery = UIAlertAction(title: "Open Photo Library", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.takePhotoFromLibrary()
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        // 4
        optionMenu.addAction(openCamera)
        optionMenu.addAction(OpenGallery)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func takePhoto() {
        self.imagePicker =  UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .camera
        
        present(imagePicker!, animated: true, completion: nil)
    }
    
    func takePhotoFromLibrary() {
        self.imagePicker =  UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .photoLibrary
        
        present(imagePicker!, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        self.profileImageView?.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.profileImageView?.layer.cornerRadius = (self.profileImageView?.bounds.width)!/2
        self.profileImageView?.clipsToBounds = true
    }
    
    
    @IBAction func logout() {
        let storyBoard = UIStoryboard.init(name: "Registration", bundle: Bundle.main)
        let loginVC = storyBoard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = loginVC
    }
    
    @IBAction func captureVideo() {
        
    }

}
