//
//  ProfileVC.swift
//  Acme Vendor App
//
//  Created by acme on 11/09/24.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var vwStartEndStack: UIStackView!
    @IBOutlet weak var txtFldEndDate: UITextField!
    @IBOutlet weak var txtFldStartDate: UITextField!
    @IBOutlet weak var txtFldZone: UITextField!
    @IBOutlet weak var txtFldArea: UITextField!
    @IBOutlet weak var txtFldGst: UITextField!
    @IBOutlet weak var txtFldLocation: UITextField!
    @IBOutlet weak var txtFldType: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldEmployeeID: UITextField!
    @IBOutlet weak var vwEmployee: UIView!
    @IBOutlet weak var lblMyProfile: UILabel!
    
    //MARK: - Variables
    var viewModel = ProfileVM()
    var vendorData: VendorListModule?
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.title == "vendor" {
            lblMyProfile.text = "Vendor Profile"
            vwEmployee.isHidden = true
            vwStartEndStack.isHidden = false
            showData(data: vendorData!)
        } else {
            lblMyProfile.text = "My Profile"
            vwEmployee.isHidden = Cookies.userInfo()?.type != "asm"
            vwStartEndStack.isHidden = Cookies.userInfo()?.type != "vendor"
            viewModel.vendorListApi { val, msg in
                let data = self.viewModel.arrVendorList?.filter({$0.id == Cookies.userInfo()?.id})
                self.showData(data: data![0])
            }
        }
    }
    
    func showData(data: VendorListModule){
        self.txtFldEmployeeID.text = data.employeeID
        self.txtFldName.text = data.name != nil ? data.name : "NA"
        self.txtFldArea.text = data.area != nil ? data.area : "NA"
        self.txtFldGst.text = data.gstNo != nil ? data.gstNo : "NA"
        self.txtFldType.text = data.type != nil ? data.type : "NA"
        self.txtFldZone.text = data.zone != nil && data.zone != "Select Zone" ? data.zone : "NA"
        self.txtFldLocation.text = data.location != nil ? data.location : "NA"
        self.txtFldPhone.text = data.phoneNumber != nil ? data.phoneNumber : "NA"
        self.txtFldEmail.text = data.email != nil ? data.email : "NA"
        
        self.txtFldStartDate.text = data.startDate != nil ? data.startDate : "NA"
        self.txtFldEndDate.text = data.endDate != nil ? data.endDate : "NA"
    }
    
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        let alert = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Logout",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.viewModel.logoutApi { val, msg in
                if val {
                    Proxy.shared.showSnackBar(message: CommonMessage.LOGGED_OUT)
                    let vc = ViewControllerHelper.getViewController(ofType: .LoginOptionsVC, StoryboardName: .Main) as! LoginOptionsVC
                    self.setView(vc: vc)
                    Cookies.deleteUserToken()
                } else {
                    if msg == CommonError.INTERNET {
                        Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                    } else {
                        Proxy.shared.showSnackBar(message: msg)
                    }
                }
            }
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
    }
}
