//
//  SiteDetailVC.swift
//  Acme Vendor App
//
//  Created by acme on 07/06/24.
//

import UIKit
import AdvancedPageControl
import SDWebImage
import CoreLocation

class SiteDetailVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var btnRetakeSelfie: UIButton!
    @IBOutlet weak var collVwNewImages: UICollectionView!
    @IBOutlet weak var imgVwSecRecce: UIImageView!
    @IBOutlet weak var cnstHeightImagesSec: NSLayoutConstraint!
    @IBOutlet weak var cnstHeightRecceImgSec: NSLayoutConstraint!
    @IBOutlet weak var vwRecceImgSecond: UIView!
    @IBOutlet weak var pgControlSecond: AdvancedPageControlView!
    @IBOutlet weak var vwSecond: UIView!
    @IBOutlet weak var txtFldLocation: UITextField!
    @IBOutlet weak var txtFldRecceName: UITextField!
    @IBOutlet weak var txtFldSiteName: UITextField!
    @IBOutlet weak var vwZO: UIStackView!
    @IBOutlet weak var vwAsm: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var txtFldOutsourceCode: UITextField!
    @IBOutlet weak var txtFldZoName: UITextField!
    @IBOutlet weak var txtFldVendorName: UITextField!
    @IBOutlet weak var txtFldArea: UITextField!
    @IBOutlet weak var txtFldZone: UITextField!
    @IBOutlet weak var cnstHeightBottomStack: NSLayoutConstraint!
    @IBOutlet weak var vwStackView: UIStackView!
    @IBOutlet weak var imgVwSignature: UIImageView!
    @IBOutlet weak var txtFldnyDamage: UITextField!
    @IBOutlet weak var txtFldRemarks: UITextField!
    @IBOutlet weak var txtFldLongitude: UITextField!
    @IBOutlet weak var txtFldLatitude: UITextField!
    @IBOutlet weak var txtFldAsmName: UITextField!
    @IBOutlet weak var txtFldDate: UITextField!
    @IBOutlet weak var txtFldCity: UITextField!
    @IBOutlet weak var txtFldDistrict: UITextField!
    @IBOutlet weak var txtFldState: UITextField!
    @IBOutlet weak var txtFldSqFt: UITextField!
    @IBOutlet weak var txtFldHeight: UITextField!
    @IBOutlet weak var txtFldWidth: UITextField!
    @IBOutlet weak var btnApprove: UIButton!
    @IBOutlet weak var pgControl: AdvancedPageControlView!
    @IBOutlet weak var collVwImages: UICollectionView!
    @IBOutlet weak var btnReject: UIButton!
    //MARK: - Variables
    var viewModel = SiteDetailVM()
    var arrImages: [String] = []
    var locationManager = CLLocationManager()
    var arrNewImages: [(String,UIImage)] = []
    var currentLoc: CLLocation!
    var siteDetail: ListingModel?
    //MARK: - Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        if Cookies.userInfo()?.type == "vendor" {
            btnReject.isHidden = siteDetail?.vendor_status == "Accepted"
            btnApprove.isHidden = siteDetail?.vendor_status == "Rejected"
            siteDetail?.vendor_status == "Accepted" ? btnApprove.setTitle("Approved", for: .normal) : btnApprove.setTitle("Approve", for: .normal)
            btnApprove.isUserInteractionEnabled = siteDetail?.vendor_status != "Accepted"
            
            siteDetail?.vendor_status == "Rejected" ? btnReject.setTitle("Rejected", for: .normal) : btnReject.setTitle("Reject", for: .normal)
            btnReject.isUserInteractionEnabled = siteDetail?.vendor_status != "Rejected"
        } else if Cookies.userInfo()?.type == "rhm" {
            btnReject.isHidden = siteDetail?.clientStatus == "Accepted"
            btnApprove.isHidden = siteDetail?.clientStatus == "Rejected"
            siteDetail?.clientStatus == "Accepted" ? btnApprove.setTitle("Approved", for: .normal) : btnApprove.setTitle("Approve", for: .normal)
            btnApprove.isUserInteractionEnabled = siteDetail?.clientStatus != "Accepted"
            
            siteDetail?.clientStatus == "Rejected" ? btnReject.setTitle("Rejected", for: .normal) : btnReject.setTitle("Reject", for: .normal)
            btnReject.isUserInteractionEnabled = siteDetail?.clientStatus != "Rejected"
        }
        cnstHeightBottomStack.constant = Cookies.userInfo()?.type != "rhm" && Cookies.userInfo()?.type != "vendor" ? 0 : 55
        vwStackView.isHidden = Cookies.userInfo()?.type != "rhm" && Cookies.userInfo()?.type != "vendor"
    }
    //MARK: - Custom method
    func setData(){
        if Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "vendor_executive" {
//            vwAsm.isHidden = true
//            vwZO.isHidden = true
        }
        
        //UPDATED IMAGES CODE
        vwSecond.isHidden = true
        cnstHeightImagesSec.constant = 0
        pgControlSecond.isHidden = true
        vwRecceImgSecond.isHidden = true
        cnstHeightRecceImgSec.constant = 0
        
        
        txtFldSiteName.text = siteDetail?.siteName
        btnEdit.isHidden = Cookies.userInfo()?.type == "zo" || Cookies.userInfo()?.type == "asm"
        txtFldnyDamage.text = siteDetail?.anyDamage
        txtFldRemarks.text = siteDetail?.remarks
        txtFldOutsourceCode.text = siteDetail?.code
        txtFldZoName.text = siteDetail?.zoName
        txtFldAsmName.text = siteDetail?.asmName
        txtFldVendorName.text = siteDetail?.vendorName
        txtFldZone.text = siteDetail?.zone
        txtFldArea.text = siteDetail?.area
        txtFldSqFt.text = siteDetail?.total
        txtFldState.text = siteDetail?.state
        txtFldDistrict.text = siteDetail?.district
        txtFldCity.text = siteDetail?.city
        txtFldLatitude.text = siteDetail?.latitude
        txtFldLongitude.text = siteDetail?.longitude
        txtFldHeight.text = siteDetail?.length
        txtFldWidth.text = siteDetail?.width
        txtFldDate.text = siteDetail?.date
        txtFldLocation.text = siteDetail?.location
        txtFldRecceName.text = siteDetail?.raccePersonName
        
        if siteDetail?.raccePersonImage != "" && siteDetail?.raccePersonImage != nil {
            imgVwSignature.sd_setImage(with: URL(string: "\(imageBaseUrl)\(siteDetail?.raccePersonImage ?? "")"), placeholderImage: .placeholderImage())
        } else {
            imgVwSignature.sd_setImage(with: URL(string: "\(imageBaseUrl)\(siteDetail?.newRaccePersonImage ?? "")"), placeholderImage: .placeholderImage())
        }
        //FOR NEW IMAGES TO BE APPROVED
        if siteDetail?.newImage != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.newImage ?? "")"))
        }
        if siteDetail?.newImage1 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.newImage1 ?? "")"))
        }
        if siteDetail?.newImage2 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.newImage2 ?? "")"))
        }
        if siteDetail?.newImage3 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.newImage3 ?? "")"))
        }
        if siteDetail?.newImage4 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.newImage4 ?? "")"))
        }
        //OLD IMAGES
        if siteDetail?.image != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image ?? "")"))
        }
        if siteDetail?.image1 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image1 ?? "")"))
        }
        if siteDetail?.image2 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image2 ?? "")"))
        }
        if siteDetail?.image3 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image3 ?? "")"))
        }
        if siteDetail?.image4 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image4 ?? "")"))
        }
        
        btnReject.isHidden = ((siteDetail?.asmStatus?.range(of: "approved", options: .caseInsensitive)) != nil)
        btnApprove.setTitle(((siteDetail?.asmStatus?.range(of: "approved", options: .caseInsensitive)) != nil) ? "Approved" : "Approve", for: .normal)
        btnApprove.isUserInteractionEnabled = ((siteDetail?.asmStatus?.range(of: "approved", options: .caseInsensitive)) != nil) ? false : true
        btnApprove.isHidden = ((siteDetail?.asmStatus?.range(of: "rejected", options: .caseInsensitive)) != nil)
        btnReject.setTitle(((siteDetail?.asmStatus?.range(of: "rejected", options: .caseInsensitive)) != nil) ? "Rejected" : "Reject", for: .normal)
        btnReject.isUserInteractionEnabled = ((siteDetail?.asmStatus?.range(of: "rejected", options: .caseInsensitive)) != nil) ? false : true
        
        
        
        DispatchQueue.main.async {
            self.pgControl.drawer = ScaleDrawer(numberOfPages: self.arrImages.count, height: 10, width: 10, space: 6, raduis: 10, currentItem: 0, indicatorColor: .black, dotsColor: .clear, isBordered: true, borderColor: .black, borderWidth: 1.0, indicatorBorderColor: .black, indicatorBorderWidth: 1.0)
            self.pgControl.numberOfPages = self.arrImages.count
        }
        collVwImages.registerNib(nibName: "SiteImagesXIB")
        collVwImages.reloadData()
        collVwNewImages.registerNib(nibName: "SiteImagesXIB")
        collVwNewImages.reloadData()
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    
    @IBAction func actionEdit(_ sender: UIButton) {
        
        if !sender.isSelected {
            collVwImages.reloadData()
            manageData(true)
            sender.isSelected = true
        } else {
            if isValidateDetails() {
                sender.isSelected = false
                let area = Double((Double(txtFldHeight.text!) ?? 0.0)*(Double(txtFldWidth.text!) ?? 0.0))
                let param: [String:AnyObject] = ["project":"\(Cookies.userInfo()?.name ?? "")",
                                                 "zone": txtFldZone.text!,
                                                 "vendor_name": txtFldVendorName.text!,
                                                 "any_damage": txtFldnyDamage.text!,
                                                 "zo_name": txtFldZoName.text!,
                                                 "status": "1",
                                                 "total" :"\(area)",
                                                 WSRequestParams.WS_REQS_PARAM_DISTRICT : txtFldDistrict.text!,
                                                 WSRequestParams.WS_REQS_PARAM_STATE: txtFldState.text!,
                                                 WSRequestParams.WS_REQS_PARAM_CITY: txtFldCity.text!,
                                                 WSRequestParams.WS_REQS_PARAM_LAT : txtFldLatitude.text!,
                                                 WSRequestParams.WS_REQS_PARAM_LONG: txtFldLongitude.text!,
                                                 WSRequestParams.WS_REQS_PARAM_LENGTH: txtFldHeight.text!,
                                                 WSRequestParams.WS_REQS_PARAM_WIDTH: txtFldWidth.text!,
                                                 WSRequestParams.WS_REQS_PARAM_DATE: txtFldDate.text!,
                                                 
                                                 WSRequestParams.WS_REQS_PARAM_REMARKS: txtFldRemarks.text ?? "",
                                                 WSRequestParams.WS_REQS_PARAM_CREATED_BY: "\(Cookies.userInfo()?.id ?? 0)",
                                                 WSRequestParams.WS_REQS_PARAM_AREA: txtFldArea.text!,
                                                 WSRequestParams.WS_REQS_PARAM_ASM_NAME: txtFldAsmName.text!,
                                                 WSRequestParams.WS_REQS_PARAM_RACCE_NAME: txtFldRecceName.text!,
                                                 WSRequestParams.WS_REQS_PARAM_LOCATION: txtFldLocation.text!,
                                                 
                                                 WSRequestParams.WS_REQS_PARAM_CODE:txtFldOutsourceCode.text!,
                                                 "vendor_id": "\(siteDetail?.vendorId ?? "")"] as! [String:AnyObject]
                
                var imgParam = [String: UIImage]()
                for image in 0..<arrNewImages.count {
                    switch image {
                    case 1:
                        if arrNewImages[image].0 == "Far Shot" {
                            imgParam["new_image"] = arrNewImages[image].1
                        }
                    case 2:
                        if arrNewImages[image].0 == "Near Shot" {
                            imgParam["new_image"] = arrNewImages[image].1
                        }
                    case 3:
                        if arrNewImages[image].0 == "Left Shot" {
                            imgParam["new_image"] = arrNewImages[image].1
                        }
                    case 4:
                        if arrNewImages[image].0 == "Right Shot" {
                            imgParam["new_image"] = arrNewImages[image].1
                        }
                    case 0:
                        imgParam["new_image4"] = arrNewImages[image].1
                    default:
                        break
                    }
                }
//                for image in 0..<arrNewImages.count {
//                    switch image {
//                    case 0:
//                        imgParam["new_image"] = arrNewImages[image]
//                    case 1:
//                        imgParam["new_image1"] = arrNewImages[image]
//                    case 2:
//                        imgParam["new_image2"] = arrNewImages[image]
//                    case 3:
//                        imgParam["new_image3"] = arrNewImages[image]
//                    case 4:
//                        imgParam["new_image4"] = arrNewImages[image]
//                    default:
//                        break
//                    }
//                }
                
              //  imgParam[WSRequestParams.WS_REQS_PARAM_RACCE_IMAGE] = imgVwSignature.image
                
                imgParam["new_racce_person_image"] = imgVwSecRecce.image
                
                if imgParam.count != 0 {
                    viewModel.updateSiteDetails(id: siteDetail?.id ?? 0, param: param, dictImage: imgParam) { val, msg in
                        if val {
                            Proxy.shared.showSnackBar(message: msg)
                            self.manageData(false)
                            self.collVwImages.reloadData()
                            self.popView()
                        } else {
                            if msg == CommonError.INTERNET {
                                Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                            } else {
                                Proxy.shared.showSnackBar(message: msg)
                            }
                        }
                    }
                } else {
                    viewModel.updateSiteDetails(id: siteDetail?.id ?? 0, param: param) { val, msg in
                        if val {
                            Proxy.shared.showSnackBar(message: msg)
                            self.manageData(false)
                            self.collVwImages.reloadData()
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
        }
    }
    
    
    @IBAction func actionBtnOpenImage(_ sender: UIButton) {
        let vc = ViewControllerHelper.getViewController(ofType: .ViewSiteVC, StoryboardName: .Main) as! ViewSiteVC
        
        
        if sender.tag == 0 {
            if siteDetail?.raccePersonImage != "" && siteDetail?.raccePersonImage != nil {
                vc.image = "\(imageBaseUrl)\(siteDetail?.raccePersonImage ?? "")"
            } else {
                vc.image = "\(imageBaseUrl)\(siteDetail?.newRaccePersonImage ?? "")"
            }
        } else {
            vc.img = imgVwSecRecce.image!
        }
        self.pushView(vc: vc, title: sender.tag == 1 ? "imageForm" : "")
    }
    
    @IBAction func actionApproveReject(_ sender: UIButton) {
        if Cookies.userInfo()?.type == "vendor" {
            switch sender.tag {
            case 0:
                let alert = UIAlertController(title: "Dalmia", message: CommonMessage.APPROVE_DETAILS, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: CommonMessage.CANCEL, style: UIAlertAction.Style.default, handler: { _ in
                }))
                alert.addAction(UIAlertAction(title: CommonMessage.APPROVE,
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                    
                    self.viewModel.acceptRejectApi(.vendorAcceptReject("\(self.siteDetail?.id ?? 0)", createdBy: "\(Cookies.userInfo()?.id ?? 0)", status: "Accepted"), param: [:]) { val, msg in
                        if val {
                            let alert = UIAlertController(title: "", message: CommonMessage.APPROVED_SUCCESSFULLY, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                                self.popView()
                            }))
                            DispatchQueue.main.async {
                                self.present(alert, animated: false, completion: nil)
                            }
                        } else {
                            if msg == CommonError.INTERNET {
                                Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                            } else {
                                Proxy.shared.showSnackBar(message: msg)
                            }
                        }
                    }
                }))
                self.present(alert, animated: false, completion: nil)
            default:
                let alert = UIAlertController(title: "Dalmia", message: CommonMessage.REJECT_DETAILS, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: CommonMessage.CANCEL, style: UIAlertAction.Style.default, handler: { _ in
                }))
                alert.addAction(UIAlertAction(title: CommonMessage.REJECT,
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                    
                    self.viewModel.acceptRejectApi(.vendorAcceptReject("\(self.siteDetail?.id ?? 0)", createdBy: "\(Cookies.userInfo()?.id ?? 0)", status: "Rejected"), param: [:]) { val, msg in
                        if val {
                            
                            let alert = UIAlertController(title: "", message: CommonMessage.REJECTED_SUCCESS, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                                self.popView()
                            }))
                            DispatchQueue.main.async {
                                self.present(alert, animated: false, completion: nil)
                            }
                            
                        } else {
                            if msg == CommonError.INTERNET {
                                Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                            } else {
                                Proxy.shared.showSnackBar(message: msg)
                            }
                        }
                    }
                }))
                self.present(alert, animated: false, completion: nil)
            }
        } else if Cookies.userInfo()?.type == "rhm" {
            switch sender.tag {
            case 0:
                let alert = UIAlertController(title: "Dalmia", message: CommonMessage.APPROVE_DETAILS, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: CommonMessage.CANCEL, style: UIAlertAction.Style.default, handler: { _ in
                }))
                alert.addAction(UIAlertAction(title: CommonMessage.APPROVE,
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                    
                    self.viewModel.acceptRejectApi(.clientAcceptReject("\(self.siteDetail?.id ?? 0)", createdBy: "\(Cookies.userInfo()?.id ?? 0)", status: "Accepted"), param: [:]) { val, msg in
                        if val {
                            let alert = UIAlertController(title: "", message: CommonMessage.APPROVED_SUCCESSFULLY, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                                self.popView()
                            }))
                            DispatchQueue.main.async {
                                self.present(alert, animated: false, completion: nil)
                            }
                        } else {
                            if msg == CommonError.INTERNET {
                                Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                            } else {
                                Proxy.shared.showSnackBar(message: msg)
                            }
                        }
                    }
                }))
                self.present(alert, animated: false, completion: nil)
            default:
                let alert = UIAlertController(title: "Dalmia", message: CommonMessage.REJECT_DETAILS, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: CommonMessage.CANCEL, style: UIAlertAction.Style.default, handler: { _ in
                }))
                alert.addAction(UIAlertAction(title: CommonMessage.REJECT,
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                    
                    self.viewModel.acceptRejectApi(.clientAcceptReject("\(self.siteDetail?.id ?? 0)", createdBy: "\(Cookies.userInfo()?.id ?? 0)", status: "Rejected"), param: [:]) { val, msg in
                        if val {
                            let alert = UIAlertController(title: "", message: CommonMessage.REJECTED_SUCCESS, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                                self.popView()
                            }))
                            DispatchQueue.main.async {
                                self.present(alert, animated: false, completion: nil)
                            }
                        } else {
                            if msg == CommonError.INTERNET {
                                Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                            } else {
                                Proxy.shared.showSnackBar(message: msg)
                            }
                        }
                    }
                }))
                self.present(alert, animated: false, completion: nil)
            }
        }
        
    }
    @IBAction func actionRetake(_ sender: Any) {
        ImagePickerManager().openSelfieCamera(self) { image in
            self.imgVwSecRecce.image = image
            self.vwRecceImgSecond.isHidden = false
            self.cnstHeightRecceImgSec.constant = 150
        }
    }
   
    func convertStringToCLLocationDegrees(latitudeString: String, longitudeString: String) -> (CLLocationDegrees, CLLocationDegrees)? {
        guard let latitude = Double(latitudeString), let longitude = Double(longitudeString) else {
            return nil // Return nil if conversion fails
        }
        
        return (latitude, longitude)
    }
}

extension SiteDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == collVwImages ? arrImages.count : arrNewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteImagesXIB", for: indexPath) as! SiteImagesXIB
        
        if collectionView == collVwImages {
            
            cell.imgVwSite.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.actionRetake.isHidden = !btnEdit.isSelected
            cell.imgVwSite.sd_setImage(with: URL(string: "\(arrImages[indexPath.row])"), placeholderImage: .placeholderImage())
            cell.actionRetake.addTarget(self, action: #selector(actionRetakePic), for: .touchUpInside)
            cell.actionRetake.tag = indexPath.row
        } else {
            //cell.imgVwSite.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.actionRetake.isHidden = true
            cell.imgVwSite.image = arrNewImages[indexPath.row].1
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: (collectionView.frame.size.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ViewControllerHelper.getViewController(ofType: .ViewSiteVC, StoryboardName: .Main) as! ViewSiteVC
        if collectionView == collVwImages {
            vc.image = arrImages[indexPath.row]
        } else {
            vc.img = arrNewImages[indexPath.row].1
        }
        self.pushView(vc: vc, title: arrNewImages.count != 0 ? "imageForm" : "")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collVwImages {
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let index = Int(round(offSet / width))
            self.pgControl.setPage(index)
            collVwNewImages.reloadData()
        }
        if scrollView == self.collVwNewImages {
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let index = Int(round(offSet / width))
            self.pgControlSecond.setPage(index)
        }
    }
    @objc func actionRetakePic(_ sender: UIButton) {
        
        let vc = ViewControllerHelper.getViewController(ofType: .ImagesOptionsVC, StoryboardName: .Main) as! ImagesOptionsVC
        vc.images = self.arrNewImages
        vc.imgTypeDelegate = {
            val in
            
            ImagePickerManager().openCamera(self) { image in
                
                
                if(self.locationManager.authorizationStatus == .authorizedWhenInUse ||
                   self.locationManager.authorizationStatus == .authorizedAlways) {
                    self.currentLoc = self.locationManager.location
                    
                    if let coordinates = self.convertStringToCLLocationDegrees(latitudeString: self.siteDetail?.latitude ?? "", longitudeString: self.siteDetail?.longitude ?? "") {
                        
                        let givenLatLong = CLLocationCoordinate2DMake(coordinates.0, coordinates.1) // Example coordinates
                        let personLatLong = CLLocationCoordinate2D(latitude: self.currentLoc.coordinate.latitude, longitude: self.currentLoc.coordinate.longitude) // Another example
                        
                        if self.isWithin200Meters(givenLocation: givenLatLong, personLocation: personLatLong) {
                            self.txtFldLatitude.text = "\(self.currentLoc.coordinate.latitude)"
                            self.txtFldLongitude.text = "\(self.currentLoc.coordinate.longitude)"
                            
                            self.arrNewImages.append((val, image))
                            self.vwSecond.isHidden = self.arrNewImages.count == 0
                            self.cnstHeightImagesSec.constant = self.arrNewImages.count == 0 ? 0 : 280
                            self.pgControlSecond.isHidden = self.arrNewImages.count == 0
                            self.pgControlSecond.drawer = ScaleDrawer(numberOfPages: self.arrNewImages.count, height: 10, width: 10, space: 6, raduis: 10, currentItem: 0, indicatorColor: .black, dotsColor: .clear, isBordered: true, borderColor: .black, borderWidth: 1.0, indicatorBorderColor: .black, indicatorBorderWidth: 1.0)
                            self.pgControlSecond.numberOfPages = self.arrNewImages.count
                            self.collVwNewImages.reloadData()
                            
                            
                            print("The person is within 200 meters.")
                        } else {
                            Proxy.shared.showSnackBar(message: "You are not within 200 meters of the site. Please retry!")
                        }
                    } else {
                        self.arrNewImages.append((val, image))
                        self.vwSecond.isHidden = self.arrNewImages.count == 0
                        self.cnstHeightImagesSec.constant = self.arrNewImages.count == 0 ? 0 : 280
                        self.pgControlSecond.isHidden = self.arrNewImages.count == 0
                        self.pgControlSecond.drawer = ScaleDrawer(numberOfPages: self.arrNewImages.count, height: 10, width: 10, space: 6, raduis: 10, currentItem: 0, indicatorColor: .black, dotsColor: .clear, isBordered: true, borderColor: .black, borderWidth: 1.0, indicatorBorderColor: .black, indicatorBorderWidth: 1.0)
                        self.pgControlSecond.numberOfPages = self.arrNewImages.count
                        self.collVwNewImages.reloadData()
                        self.txtFldLatitude.text = "\(self.currentLoc.coordinate.latitude)"
                        self.txtFldLongitude.text = "\(self.currentLoc.coordinate.longitude)"
                    }
                }
            }
        }
        self.present(vc, animated: true)
    }
    
    func isWithin200Meters(givenLocation: CLLocationCoordinate2D, personLocation: CLLocationCoordinate2D) -> Bool {
        let givenCLLocation = CLLocation(latitude: givenLocation.latitude, longitude: givenLocation.longitude)
        let personCLLocation = CLLocation(latitude: personLocation.latitude, longitude: personLocation.longitude)
        
        let distance = givenCLLocation.distance(from: personCLLocation)
        
        return distance <= 200.0 // distance is in meters
    }
    
    func manageData(_ data: Bool) {
        btnRetakeSelfie.isHidden = !data
        txtFldWidth.isUserInteractionEnabled = data
        txtFldnyDamage.isUserInteractionEnabled = data
        txtFldRemarks.isUserInteractionEnabled = data
        txtFldOutsourceCode.isUserInteractionEnabled = data
        txtFldZoName.isUserInteractionEnabled = data
        txtFldAsmName.isUserInteractionEnabled = data
        txtFldVendorName.isUserInteractionEnabled = data
        txtFldZone.isUserInteractionEnabled = data
        txtFldArea.isUserInteractionEnabled = data
        txtFldState.isUserInteractionEnabled = data
        txtFldDistrict.isUserInteractionEnabled = data
        txtFldCity.isUserInteractionEnabled = data
        txtFldHeight.isUserInteractionEnabled = data
        txtFldLocation.isUserInteractionEnabled = data
        txtFldRecceName.isUserInteractionEnabled = data
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
        } else if txtFldDistrict.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_DISTRICT)
            return false
        } else if txtFldCity.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_CITY)
            return false
        } else if txtFldZone.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_ZONE)
            return false
        } else if txtFldVendorName.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_VENDOR_NAME)
            return false
        } else if txtFldDate.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_DATE)
            return false
        } 
        else if txtFldRecceName.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: "Please enter Recce person name")
            return false
        } else if txtFldLocation.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: "Please enter your location")
            return false
        } 
//        else if arrImages.count != 5 {
//            Proxy.shared.showSnackBar(message: "There must be 5 store photos")
//            return false
//        }
        return true
    }
}
