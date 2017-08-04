//
//  AgreementViewController.swift
//  uHype
//
//  Created by Ashish Mishra on 7/7/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class AgreementViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showUserAgrrement()

        // Do any additional setup after loading the view.
    }
    
    func showUserAgrrement() {
        if let pdf = Bundle.main.url(forResource: "rules", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = URLRequest(url: pdf)
            let webView = UIWebView(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height-100))
            webView.loadRequest(req)
            self.view.addSubview(webView)
        }
    }
    
    @IBAction func iAgreeClicked() {
        
    }
    
    @IBAction func idisAgreeClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}
