//
//  VendorLoginVC.swift
//  Acme Vendor App
//
//  Created by acme on 17/10/24.
//

import UIKit

class VendorLoginVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    //MARK: - Variables
    var viewModel = OtpVM()
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - @IBActions
    @IBAction func actionNext(_ sender: Any) {
        if txtFldEmail.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_EMAIL)
        } else if txtFldEmail.text?.isValidEmail() == false {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_VALID_EMAIL)
        } else if txtFldPassword.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: "Please enter password")
        } else {
            let param = [WSRequestParams.WS_REQS_PARAM_EMAIL: txtFldEmail.text!,
                         WSRequestParams.WS_REQS_PARAM_PASSWORD: txtFldPassword.text!] as! [String:AnyObject]
            viewModel.otpVerifyApi(param) { val, msg in
                if val {
                    let vc = ViewControllerHelper.getViewController(ofType: .ListingVC, StoryboardName: .Main) as! ListingVC
                    self.setView(vc: vc)
                } else {
                    if msg == CommonError.INTERNET {
                        Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                    } else {
                        Proxy.shared.showSnackBar(message: msg)
                    }
                }
            }
        }
    }
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
}
