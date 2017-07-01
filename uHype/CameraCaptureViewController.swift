//
//  CameraCaptureViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 6/26/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit
import AVFoundation

class CameraCaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentInteractionControllerDelegate {
    
    var imagePicker : UIImagePickerController!
    @IBOutlet var profileImageView : UIImageView?

    var documentController :  UIDocumentInteractionController?
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
    
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image : UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        self.profileImageView?.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.shareToInstagram(image: image)
    }
    
    
    func shareToInstagram(image : UIImage?) {
        
        let instagramURL = NSURL(string: "instagram://app")
        
        if (UIApplication.shared.canOpenURL(instagramURL! as URL)) {
            
            let imageData = UIImageJPEGRepresentation(image!, 100)
            
            let captionString = "caption"
            
            let writePath = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.igo")
            
            
            do {
                try imageData?.write(to: URL(fileURLWithPath: writePath))
                let fileURL = NSURL(fileURLWithPath: writePath)
                
                self.documentController = UIDocumentInteractionController(url: fileURL as URL)
                
                self.documentController?.delegate = self
                
                self.documentController?.uti = "com.instagram.exlusivegram"
                
                self.documentController?.annotation = NSDictionary(object: captionString, forKey: "InstagramCaption" as NSCopying)
                self.documentController?.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
            } catch  {
                print(error)
            }
            
        } else {
            print(" Instagram isn't installed ")
        }
    }
    
    @IBAction func logout() {
        let storyBoard = UIStoryboard.init(name: "Registration", bundle: Bundle.main)
        let loginVC = storyBoard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = loginVC
    }
    
    @IBAction func captureVideo() {
        
    }

}
