//
//  LoginOptionsVC.swift
//  Acme Vendor App
//
//  Created by acme on 17/10/24.
//

import UIKit

class LoginOptionsVC: UIViewController {
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - @IBActions
    @IBAction func actionLoginNotLogin(_ sender: UIButton) {
        if sender.tag == 0 {
            let vc = ViewControllerHelper.getViewController(ofType: .VendorLoginVC, StoryboardName: .Main) as! VendorLoginVC
            self.pushView(vc: vc)
        } else {
            let vc = ViewControllerHelper.getViewController(ofType: .LoginVC, StoryboardName: .Main) as! LoginVC
            self.pushView(vc: vc)
        }
    }
}
