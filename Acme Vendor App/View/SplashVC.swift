//
//  SplashVC.swift
//  Acme Vendor App
//
//  Created by acme on 04/06/24.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            let userToken = Cookies.getUserToken()
            
            if userToken != "" {
                let vc = ViewControllerHelper.getViewController(ofType: .ListingVC, StoryboardName: .Main) as! ListingVC
                self.setView(vc: vc)
            } else{
                let vc = ViewControllerHelper.getViewController(ofType: .LoginOptionsVC, StoryboardName: .Main) as! LoginOptionsVC
                self.setView(vc: vc)
            }
        })
    }
}
