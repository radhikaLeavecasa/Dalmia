//
//  AdminHomeVC.swift
//  Acme Vendor App
//
//  Created by acme on 07/09/24.
//

import UIKit
import DropDown
import CoreLocation

class AdminHomeVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var txtFldSiteName: UITextField!
    @IBOutlet weak var vwZO: UIStackView!
    @IBOutlet weak var vwASM: UIStackView!
    @IBOutlet weak var txtFldArea: UITextField!
    @IBOutlet weak var imgVwAddPhoto: UIImageView!
    @IBOutlet weak var imgVwSitePhoto: UIImageView!
    @IBOutlet weak var lblRetakeSitePhoto: UILabel!
    @IBOutlet weak var btnOwnerSignature: UIButton!
    @IBOutlet weak var imgVwOwnerSignature: UIImageView!
    @IBOutlet weak var cnstHeightSignatureOfOwner: NSLayoutConstraint!
    @IBOutlet weak var cnstHeightStorePhoto4: NSLayoutConstraint!
    @IBOutlet weak var cnstHeightStorePhoto3: NSLayoutConstraint!
    @IBOutlet weak var cnstHeightStorePhoto2: NSLayoutConstraint!
    @IBOutlet weak var cnstHeightStorePhoto1: NSLayoutConstraint!
    @IBOutlet var imgVwStorePhoto: [UIImageView]!
    @IBOutlet var btnStorePhoto: [UIButton]!
    @IBOutlet weak var txtxFldRemarks: UITextField!
    @IBOutlet weak var txtFldLongitude: UITextField!
    @IBOutlet weak var txtFldLatitude: UITextField!
    @IBOutlet weak var txtFldAsmName: UITextField!
    @IBOutlet weak var txtFldDate: UITextField!
    @IBOutlet weak var txtFldVendorName: UITextField!
    @IBOutlet weak var txtFldCity: UITextField!
    @IBOutlet weak var txtFldDistrict: UITextField!
    @IBOutlet weak var txtFldZone: UITextField!
    @IBOutlet weak var txtFldState: UITextField!
    @IBOutlet weak var txtFldSqFt: UITextField!
    @IBOutlet weak var txtFldHeight: UITextField!
    @IBOutlet weak var txtFldZoName: UITextField!
    @IBOutlet weak var txtFldWidth: UITextField!
    @IBOutlet weak var txtFldAnyDamage: UITextField!
    @IBOutlet weak var txtFldOutdoorCode: UITextField!
    @IBOutlet weak var txtFldLocation: UITextField!
    @IBOutlet weak var txtFldYourName: UITextField!
    //MARK: - Variables
    var code = String()
    var arrAnyDamage = ["Yes", "No"]
    var viewModel = HomeVM()
    let dropDown = DropDown()
    var arrVendorList = [String]()
    var arrVendorId = [Int]()
    var vendorId = Int()
    var locationManager = CLLocationManager()
    var selectedDate = Date()
    var currentLoc: CLLocation!
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if title == "Reminder" {
            txtFldOutdoorCode.text = code
            fetchDAta()
            MyLocationManager.shared.requestLocationAuthorization()
        }
        
        txtFldState.text = Cookies.userInfo()?.state
        txtFldZone.text = Cookies.userInfo()?.zone
        txtFldArea.text = Cookies.userInfo()?.area
        if Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "vendor_executive" {
//            vwASM.isHidden = true
//            vwZO.isHidden = true
            txtFldVendorName.text = Cookies.userInfo()?.name
            txtFldVendorName.isUserInteractionEnabled = false
        }
        self.locationManager.requestWhenInUseAuthorization()
        viewModel.vendorListApi { val, msg in
            for i in self.viewModel.arrVendorList ?? [] {
                self.arrVendorList.append(i.name ?? "")
                self.arrVendorId.append(i.id ?? 0)
            }
        }
        self.txtFldDate.text = "\(self.convertDateToString(Date(), format: "yyyy-MM-dd")), \(self.convertDateToString(Date(), format: "HH:mm"))"
        self.txtFldDate.isUserInteractionEnabled = false
        txtFldState.isUserInteractionEnabled = txtFldState.text == ""
        txtFldZone.isUserInteractionEnabled = txtFldZone.text == ""
        txtFldArea.isUserInteractionEnabled = txtFldArea.text == ""
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    @IBAction func actionFetch(_ sender: Any) {
        view.endEditing(true)
        if txtFldOutdoorCode.text == "" {
            Proxy.shared.showSnackBar(message: AlertStrings.ENTER_OUTDOOR_SITE_CODE)
        } else {
            fetchDAta()
        }
    }
    
    func fetchDAta(){
        viewModel.fetchApi(txtFldOutdoorCode.text ?? "", id: "\(Cookies.userInfo()?.id ?? 0)") {val,msg in
            if val {
                let dict = self.viewModel.homeModel
                
                self.txtFldHeight.text = dict?.height
                self.txtFldWidth.text = dict?.width
                self.txtFldSqFt.text = dict?.total
                self.txtFldSiteName.text = dict?.location
                self.txtFldZone.text = dict?.zone
                self.txtFldAsmName.text = dict?.asm
                self.txtFldCity.text = dict?.city
                self.txtFldVendorName.text = dict?.vendor
                self.txtFldDistrict.text = dict?.district
                self.txtFldZoName.text = dict?.zo
                self.txtFldState.text = dict?.state
                //self.txtFldSiteName.text = dict?.siteName
                self.txtFldLatitude.text = dict?.lat
                self.txtFldLongitude.text = dict?.long
                self.txtFldLocation.text = dict?.location
                self.txtFldYourName.text = Cookies.userInfo()?.name
                
                
                self.txtFldAsmName.isUserInteractionEnabled = self.txtFldAsmName.text == ""
                self.txtFldCity.isUserInteractionEnabled = self.txtFldCity.text == ""
                self.txtFldDistrict.isUserInteractionEnabled = self.txtFldDistrict.text == ""
                self.txtFldState.isUserInteractionEnabled = self.txtFldState.text == ""
                
                self.txtFldHeight.isUserInteractionEnabled = self.txtFldHeight.text == ""
                self.txtFldWidth.isUserInteractionEnabled = self.txtFldWidth.text == ""
                self.txtFldZone.isUserInteractionEnabled = self.txtFldZone.text == ""
                self.txtFldVendorName.isUserInteractionEnabled = self.txtFldVendorName.text == ""
                
                self.txtFldZoName.isUserInteractionEnabled = self.txtFldZoName.text == ""
                self.txtFldLatitude.isUserInteractionEnabled = self.txtFldLatitude.text == ""
                self.txtFldLongitude.isUserInteractionEnabled = self.txtFldLongitude.text == ""
                
                self.txtFldDate.text = "\(self.convertDateToString(Date(), format: "yyyy-MM-dd")), \(self.convertDateToString(Date(), format: "HH:mm"))"
                
                self.txtFldOutdoorCode.resignFirstResponder()
            }else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                } else {
                    Proxy.shared.showSnackBar(message: msg)
                }
            }
        }
    }
    
    @IBAction func actionAddSitePhoto(_ sender: Any) {
        ImagePickerManager().openCamera(self) { [self] image in
            
            if(self.locationManager.authorizationStatus == .authorizedWhenInUse ||
               self.locationManager.authorizationStatus == .authorizedAlways) {
                self.currentLoc = self.locationManager.location
                
                if let coordinates = convertStringToCLLocationDegrees(latitudeString: self.viewModel.homeModel?.lat ?? "", longitudeString: self.viewModel.homeModel?.long ?? "") {
                    
                    let givenLatLong = CLLocationCoordinate2DMake(coordinates.0, coordinates.1) // Example coordinates
                    let personLatLong = CLLocationCoordinate2D(latitude: self.currentLoc.coordinate.latitude, longitude: self.currentLoc.coordinate.longitude) // Another example
                    
                    if self.isWithin200Meters(givenLocation: givenLatLong, personLocation: personLatLong) {
                        self.txtFldLatitude.text = "\(self.currentLoc.coordinate.latitude)"
                        self.txtFldLongitude.text = "\(self.currentLoc.coordinate.longitude)"
                        self.imgVwSitePhoto.image = image
                        self.lblRetakeSitePhoto.text = "Retake Site Photograph"
                        self.lblRetakeSitePhoto.font = UIFont(name: "DMSans18pt-Black", size: 14)
                        print("The person is within 200 meters.")
                    } else {
                        Proxy.shared.showSnackBar(message: "You are not within 200 meters of the site. Please retry!")
                    }
                } else {
                    self.imgVwSitePhoto.image = image
                    self.lblRetakeSitePhoto.text = "Retake Site Photograph"
                    self.lblRetakeSitePhoto.font = UIFont(name: "DMSans18pt-Black", size: 14)
                    self.txtFldLatitude.text = "\(self.currentLoc.coordinate.latitude)"
                    self.txtFldLongitude.text = "\(self.currentLoc.coordinate.longitude)"
                }
            }
        }
    }
    
    func convertStringToCLLocationDegrees(latitudeString: String, longitudeString: String) -> (CLLocationDegrees, CLLocationDegrees)? {
        guard let latitude = Double(latitudeString), let longitude = Double(longitudeString) else {
            return nil // Return nil if conversion fails
        }
        
        return (latitude, longitude)
    }
    @IBAction func actionStorePhotos(_ sender: UIButton) {
        ImagePickerManager().openCamera(self) { image in
            self.imgVwStorePhoto[sender.tag].image = image
            self.btnStorePhoto[sender.tag].titleLabel?.font = UIFont(name: "DMSans18pt-Black", size: 14)
            switch sender.tag {
            case 0:
                self.cnstHeightStorePhoto1.constant = 80
                self.btnStorePhoto[sender.tag].setTitle("Retake Far Shot", for: .normal)

            case 1:
                self.cnstHeightStorePhoto2.constant = 80
                self.btnStorePhoto[sender.tag].setTitle("Retake Near Shot", for: .normal)

            case 2:
                self.cnstHeightStorePhoto3.constant = 80
                self.btnStorePhoto[sender.tag].setTitle("Retake Left Angle", for: .normal)

            case 3:
                self.cnstHeightStorePhoto4.constant = 80
                self.btnStorePhoto[sender.tag].setTitle("Retake Right Angle", for: .normal)

            default:
                break
            }
        }
    }
    @IBAction func actionSignature(_ sender: Any) {
        
        ImagePickerManager().openSelfieCamera(self, { image in
//            self.imgVwSitePhoto.image = image
//            self.lblRetakeSitePhoto.text = "Retake Selfie"
//            self.lblRetakeSitePhoto.font = UIFont(name: "DMSans18pt-Black", size: 14)
            
            self.cnstHeightSignatureOfOwner.constant = 80
            self.imgVwOwnerSignature.image = image
            self.btnOwnerSignature.titleLabel?.font = UIFont(name: "DMSans18pt-Black", size: 14)
            self.btnOwnerSignature.setTitle("Retake Selfie", for: .normal)
            
            if(self.locationManager.authorizationStatus == .authorizedWhenInUse ||
               self.locationManager.authorizationStatus == .authorizedAlways) {
                self.currentLoc = self.locationManager.location
                self.txtFldLatitude.text = "\(self.currentLoc.coordinate.latitude)"
                self.txtFldLongitude.text = "\(self.currentLoc.coordinate.longitude)"
            }
        })
        
        
//        if let vc = ViewControllerHelper.getViewController(ofType: .SignaturePopVC, StoryboardName: .Main) as? SignaturePopVC {
//            vc.modalPresentationStyle = .overFullScreen
//            vc.modalTransitionStyle = .crossDissolve
//            
//            vc.eSignDelegate = { signImg in
//                self.cnstHeightSignatureOfOwner.constant = 80
//                self.imgVwOwnerSignature.image = signImg
//                self.btnOwnerSignature.titleLabel?.font = UIFont(name: "DMSans18pt-Black", size: 14)
//                self.btnOwnerSignature.setTitle("Retake Signature of owner", for: .normal)
//            }
//            self.present(vc, animated: true)
//        }
    }
    @IBAction func actionUploadSiteDetails(_ sender: UIButton) {
        if sender.tag == 0 {
            if isValidateDetails() {
                let area = Double((Double(txtFldHeight.text!) ?? 0.0)*(Double(txtFldWidth.text!) ?? 0.0))
                let param: [String:AnyObject] = ["project":"\(Cookies.userInfo()?.name ?? "")",
                                                 "zone": txtFldZone.text!,
                                                 "vendor_name": txtFldVendorName.text!,
                                                 "any_damage": txtFldAnyDamage.text!,
                                                 //"zo_name": txtFldZoName.text!,
                                                 "status": "1",
                                                 "total" :"\(area)",
                                                 "site_name": txtFldSiteName.text!,
                                                 //WSRequestParams.WS_REQS_PARAM_DISTRICT : txtFldDistrict.text!,
                                                 WSRequestParams.WS_REQS_PARAM_STATE: txtFldState.text!,
                                                 WSRequestParams.WS_REQS_PARAM_CITY: txtFldCity.text!,
                                                 WSRequestParams.WS_REQS_PARAM_LAT : txtFldLatitude.text!,
                                                 WSRequestParams.WS_REQS_PARAM_LONG: txtFldLongitude.text!,
                                                 WSRequestParams.WS_REQS_PARAM_LENGTH: txtFldHeight.text!,
                                                 WSRequestParams.WS_REQS_PARAM_WIDTH: txtFldWidth.text!,
                                                 WSRequestParams.WS_REQS_PARAM_DATE: txtFldDate.text!,
                                                 
                                                 WSRequestParams.WS_REQS_PARAM_REMARKS: txtxFldRemarks.text ?? "",
                                                 WSRequestParams.WS_REQS_PARAM_CREATED_BY: "\(Cookies.userInfo()?.id ?? 0)",
                                                 //WSRequestParams.WS_REQS_PARAM_AREA: txtFldState.text!,
                                                 //WSRequestParams.WS_REQS_PARAM_ASM_NAME: txtFldAsmName.text!,
                                                 
                                                 WSRequestParams.WS_REQS_PARAM_RACCE_NAME: txtFldYourName.text!,
                                                 WSRequestParams.WS_REQS_PARAM_LOCATION: txtFldLocation.text!,
                                                 
                                                 WSRequestParams.WS_REQS_PARAM_CODE:txtFldOutdoorCode.text!,
                                                 "vendor_id": "\(vendorId)"] as! [String:AnyObject]
                var imgParam2: [String: UIImage]?
                let imgParam: [String: UIImage?] = [
                    "image": imgVwSitePhoto.image,
                    "image1": imgVwStorePhoto.indices.contains(0) ? imgVwStorePhoto[0].image : nil,
                    "image2": imgVwStorePhoto.indices.contains(1) ? imgVwStorePhoto[1].image : nil,
                    "image3": imgVwStorePhoto.indices.contains(2) ? imgVwStorePhoto[2].image : nil,
                    "image4": imgVwStorePhoto.indices.contains(3) ? imgVwStorePhoto[3].image : nil
                ]
                
                imgParam2 = imgParam.compactMapValues { $0 }
                let nonNilImagesCount = (imgParam2?.compactMap { $0 }.count) ?? 0
                if nonNilImagesCount < 3 {
                    Proxy.shared.showSnackBar(message: "Add atleast 3 site images")
                } else {
                    imgParam2?[WSRequestParams.WS_REQS_PARAM_RACCE_IMAGE] = imgVwOwnerSignature.image
                    viewModel.uploadSiteDetails(param: param, dictImage: imgParam2 ?? [:]) { val, msg in
                        if val {
                            Proxy.shared.showSnackBar(message: msg)
                           // self.resetData()
                            self.popView()
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
        } else {
            resetData()
        }
    }
    //MARK: - Custom method
    
    func isWithin200Meters(givenLocation: CLLocationCoordinate2D, personLocation: CLLocationCoordinate2D) -> Bool {
        let givenCLLocation = CLLocation(latitude: givenLocation.latitude, longitude: givenLocation.longitude)
        let personCLLocation = CLLocation(latitude: personLocation.latitude, longitude: personLocation.longitude)
        
        let distance = givenCLLocation.distance(from: personCLLocation)
        
        return distance <= 20000.0 // distance\
        self.imgVwSitePhoto.image = nil
        self.imgVwStorePhoto[0].image = nil
        self.imgVwStorePhoto[1].image = nil
        self.imgVwStorePhoto[2].image = nil
        self.imgVwStorePhoto[3].image = nil
        self.imgVwOwnerSignature.image = nil
        
        self.cnstHeightStorePhoto1.constant = 40
        self.cnstHeightStorePhoto2.constant = 40
        self.cnstHeightStorePhoto3.constant = 40
        self.cnstHeightStorePhoto4.constant = 40
        self.cnstHeightSignatureOfOwner.constant = 40
        
        self.btnStorePhoto[0].setTitle("Far Shot", for: .normal)
        self.btnStorePhoto[1].setTitle("Near Shot", for: .normal)
        self.btnStorePhoto[2].setTitle("Left Angle", for: .normal)
        self.btnStorePhoto[3].setTitle("Right Angle", for: .normal)
        self.btnOwnerSignature.setTitle("Your Selfie", for: .normal)
        self.lblRetakeSitePhoto.text = "Add Site Photograph"
        
        self.btnOwnerSignature.titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        self.btnStorePhoto[0].titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        self.btnStorePhoto[1].titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        self.btnStorePhoto[2].titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        self.btnStorePhoto[3].titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        // self.lblRetakeSitePhoto.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        txtFldVendorName.text = ""
        txtFldZone.text = ""
    }
    
    func resetData(){
        self.txtFldSqFt.text = ""
        //        self.txtFldLocation.text = ""
        //        self.txtFldAsmNumber.text = ""
        self.txtFldAsmName.text = ""
        self.txtFldZoName.text = ""
        self.txtFldCity.text = ""
        // self.txtFldOwnerMobile.text = ""
        self.txtFldDistrict.text = ""
        // self.txtFldShopName.text = ""
        self.txtFldState.text = ""
        self.txtFldDate.text = ""
        self.txtFldOutdoorCode.text = ""
        self.txtFldHeight.text = ""
        self.txtFldWidth.text = ""
        //        self.txtFldOwnerName.text = ""
        self.txtFldArea.text = ""
        self.txtFldAnyDamage.text = ""
        self.txtFldLatitude.text = ""
        self.txtFldLongitude.text = ""
        self.txtxFldRemarks.text = ""
        self.imgVwSitePhoto.image = nil
        self.imgVwStorePhoto[0].image = nil
        self.imgVwStorePhoto[1].image = nil
        self.imgVwStorePhoto[2].image = nil
        self.imgVwStorePhoto[3].image = nil
        self.imgVwOwnerSignature.image = nil
        
        self.cnstHeightStorePhoto1.constant = 40
        self.cnstHeightStorePhoto2.constant = 40
        self.cnstHeightStorePhoto3.constant = 40
        self.cnstHeightStorePhoto4.constant = 40
        self.cnstHeightSignatureOfOwner.constant = 40
        
        self.btnStorePhoto[0].setTitle("Far Shot", for: .normal)
        self.btnStorePhoto[1].setTitle("Near Shot", for: .normal)
        self.btnStorePhoto[2].setTitle("Left Angle", for: .normal)
        self.btnStorePhoto[3].setTitle("Right Angle", for: .normal)
        self.btnOwnerSignature.setTitle("Your Selfie", for: .normal)
        self.lblRetakeSitePhoto.text = "Add Site Photograph"
        
        self.btnOwnerSignature.titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        self.btnStorePhoto[0].titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        self.btnStorePhoto[1].titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        self.btnStorePhoto[2].titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        self.btnStorePhoto[3].titleLabel?.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        // self.lblRetakeSitePhoto.font = UIFont(name: "DMSans24pt-Regular", size: 14)
        txtFldVendorName.text = ""
        txtFldZone.text = ""
    }
    
    func isValidateDetails() -> Bool {
        if txtFldHeight.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_HEIGHT)
            return false
        } else if txtFldWidth.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_WIDTH)
            return false
        } else if txtFldState.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_STATE)
            return false
        } 
//        else if txtFldDistrict.text?.isEmptyCheck() == true {
//            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_DISTRICT)
//            return false
//        } 
        else if txtFldCity.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_CITY)
            return false
        } else if txtFldZone.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_ZONE)
            return false
        } else if txtFldVendorName.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_VENDOR_NAME)
            return false
        } else if txtFldSiteName.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_SITE_NAME)
            return false
        } else if txtFldDate.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_DATE)
            return false
        } else if txtFldYourName.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_RECCE_NAME)
            return false
        } else if txtFldLocation.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_RECCE_LOCATION)
            return false
        } 
//        else if imgVwStorePhoto.count < 3 {
//            Proxy.shared.showSnackBar(message: "There must be atleast 3 site photos")
//            return false
//        } 
        else if imgVwOwnerSignature.image == nil {
            Proxy.shared.showSnackBar(message: CommonMessage.ADD_SIGNATURE_OF_OWNER)
            return false
        }
        else if txtFldLatitude.text?.isEmptyCheck() == true && txtFldLongitude.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.LAT_LONG_FETCH)
            return false
        }
        return true
    }
}

extension AdminHomeVC: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == txtFldWidth || textField == txtFldHeight {
            if txtFldHeight.text != "" && txtFldWidth.text != "" {
                txtFldSqFt.text = "\(Double((Double(txtFldHeight.text!) ?? 0.0)*(Double(txtFldWidth.text!) ?? 0.0)))"
            }
        } else if textField == txtFldSiteName {
            txtFldLocation.text = txtFldSiteName.text
            txtFldLocation.isUserInteractionEnabled = false
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtFldVendorName {
            self.showShortDropDown(textFeild: textField, data: self.arrVendorList, dropDown: dropDown) { val, index in
                self.txtFldVendorName.text = val
                self.vendorId = self.arrVendorId[index]
            }
            return false
        } else if textField == txtFldAnyDamage {
            self.showShortDropDown(textFeild: textField, data: self.arrAnyDamage, dropDown: dropDown) { val, index in
                self.txtFldAnyDamage.text = val
            }
            return false
        } else {
            return true
        }
    }
}
