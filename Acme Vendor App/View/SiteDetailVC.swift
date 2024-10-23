//
//  SiteDetailVC.swift
//  Acme Vendor App
//
//  Created by acme on 07/06/24.
//

import UIKit
import AdvancedPageControl
import SDWebImage

class SiteDetailVC: UIViewController {
    //MARK: - @IBOutlets
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
    var arrImages: [(String,UIImage?)] = []
    var siteDetail: ListingModel?
    //MARK: - Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        cnstHeightBottomStack.constant = 0
        vwStackView.isHidden = true
    }
    //MARK: - Custom method
    func setData(){
        if Cookies.userInfo()?.type == "vendor" {
            vwAsm.isHidden = true
            vwZO.isHidden = true
        }
        txtFldSiteName.text = siteDetail?.siteName
        btnEdit.isHidden = Cookies.userInfo()?.type != "admin"
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
        imgVwSignature.sd_setImage(with: URL(string: "\(imageBaseUrl)\(siteDetail?.ownerSignature ?? "")"), placeholderImage: .placeholderImage())
        if siteDetail?.image != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image ?? "")", nil))
        }
        if siteDetail?.image1 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image1 ?? "")", nil))
        }
        if siteDetail?.image2 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image2 ?? "")", nil))
        }
        if siteDetail?.image3 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image3 ?? "")", nil))
        }
        if siteDetail?.image4 != nil {
            arrImages.append(("\(imageBaseUrl)\(siteDetail?.image4 ?? "")", nil))
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
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    //    @IBAction func actionAcceptReject(_ sender: UIButton) {
    //        switch sender.tag {
    //        case 0:
    //            let alert = UIAlertController(title: CommonMessage.ACME_VENDOR, message: CommonMessage.APPROVE_DETAILS, preferredStyle: .alert)
    //            alert.addAction(UIAlertAction(title: CommonMessage.CANCEL, style: UIAlertAction.Style.default, handler: { _ in
    //            }))
    //            alert.addAction(UIAlertAction(title: CommonMessage.APPROVE,
    //                                          style: UIAlertAction.Style.default,
    //                                          handler: {(_: UIAlertAction!) in
    //                let param = [WSRequestParams.WS_REQS_PARAM_ASM_STATUS: "approved",
    //                             WSRequestParams.WS_REQS_PARAM_ASM_APPROVE_ID: Cookies.userInfo()?.id ?? 0,
    //                             WSRequestParams.WS_REQS_PARAM_PROJECT_ID: self.siteDetail?.id ?? 0] as! [String:AnyObject]
    ////                self.viewModel.acceptRejectApi(param) { val, msg in
    ////                    if val {
    ////                        Proxy.shared.showSnackBar(message: CommonMessage.APPROVED_SUCCESSFULLY)
    ////                        self.popView()
    ////                    } else {
    ////                        if msg == CommonError.INTERNET {
    ////                            Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
    ////                        } else {
    ////                            Proxy.shared.showSnackBar(message: msg)
    ////                        }
    ////                    }
    ////                }
    //            }))
    //            self.present(alert, animated: false, completion: nil)
    //        default:
    //            let alert = UIAlertController(title: CommonMessage.ACME_VENDOR, message: CommonMessage.REJECT_DETAILS, preferredStyle: .alert)
    //            alert.addAction(UIAlertAction(title: CommonMessage.CANCEL, style: UIAlertAction.Style.default, handler: { _ in
    //            }))
    //            alert.addAction(UIAlertAction(title: CommonMessage.REJECT,
    //                                          style: UIAlertAction.Style.default,
    //                                          handler: {(_: UIAlertAction!) in
    //
    //                let vc = ViewControllerHelper.getViewController(ofType: .RejectionVC, StoryboardName: .Main) as! RejectionVC
    //                vc.modalPresentationStyle = .overFullScreen
    //                vc.modalTransitionStyle = .crossDissolve
    //
    //                vc.remarksDelegate = { remarks in
    //                    let param = [WSRequestParams.WS_REQS_PARAM_ASM_STATUS: "rejected",
    //                                 WSRequestParams.WS_REQS_PARAM_ASM_APPROVE_ID: Cookies.userInfo()?.id ?? 0,
    //                                 WSRequestParams.WS_REQS_PARAM_PROJECT_ID: self.siteDetail?.id ?? 0,
    //                                 WSRequestParams.WS_REQS_PARAM_ASM_REMARKS:remarks] as! [String:AnyObject]
    //                    self.viewModel.acceptRejectApi(param) { val, msg in
    //                        if val {
    //                            self.popView()
    //                            Proxy.shared.showSnackBar(message: CommonMessage.REJECTED_SUCCESS)
    //                        } else {
    //                            if msg == CommonError.INTERNET {
    //                                Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
    //                            } else {
    //                                Proxy.shared.showSnackBar(message: msg)
    //                            }
    //                        }
    //                    }
    //                }
    //                self.present(vc, animated: true)
    //            }))
    //            self.present(alert, animated: false, completion: nil)
    //        }
    //    }
    @IBAction func actionEdit(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            collVwImages.reloadData()
            manageData(true)
        } else {
            if isValidateDetails() {
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
                                                 //  WSRequestParams.WS_REQS_PARAM_DIVISION: viewModel.homeModel?.division ?? "",
                                                 //  WSRequestParams.WS_REQS_PARAM_RETAILER_CODE: txtFldOutdoorCode.text!,
                                                 
                                                 WSRequestParams.WS_REQS_PARAM_CODE:txtFldOutsourceCode.text!,
                                                 "vendor_id": "\(siteDetail?.vendorId ?? "")"] as! [String:AnyObject]
                
                var imgParam = [String: UIImage]()
                for (index, image) in arrImages.enumerated() {
                    if let image = image.1 {
                        switch index {
                        case 0:
                            imgParam[WSRequestParams.WS_REQS_PARAM_IMAGE] = image
                        case 1:
                            imgParam[WSRequestParams.WS_REQS_PARAM_IMAGE1] = image
                        case 2:
                            imgParam[WSRequestParams.WS_REQS_PARAM_IMAGE2] = image
                        case 3:
                            imgParam[WSRequestParams.WS_REQS_PARAM_IMAGE3] = image
                        case 4:
                            imgParam[WSRequestParams.WS_REQS_PARAM_IMAGE4] = image
                        default:
                            break
                        }
                    }
                    if imgParam.count != 0 {
                        viewModel.updateSiteDetails(id: siteDetail?.id ?? 0, param: param, dictImage: imgParam) { val, msg in
                            if val {
                                Proxy.shared.showSnackBar(message: msg)
                                self.manageData(false)
                                self.collVwImages.reloadData()
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
    }
}

extension SiteDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collVwImages.dequeueReusableCell(withReuseIdentifier: "SiteImagesXIB", for: indexPath) as! SiteImagesXIB
        cell.imgVwSite.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.actionRetake.isHidden = !btnEdit.isSelected
        if arrImages[indexPath.row].1 == nil {
            cell.imgVwSite.sd_setImage(with: URL(string: "\(arrImages[indexPath.row].0)"), placeholderImage: .placeholderImage())
        } else {
            cell.imgVwSite.image = arrImages[indexPath.row].1
        }
        cell.actionRetake.addTarget(self, action: #selector(actionRetakePic), for: .touchUpInside)
        cell.actionRetake.tag = indexPath.row
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.collVwImages.frame.size.width, height: (self.collVwImages.frame.size.height))
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collVwImages {
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let index = Int(round(offSet/width))
            self.pgControl.setPage(index)
        }
    }
    @objc func actionRetakePic(_ sender: UIButton) {
        ImagePickerManager().openCamera(self) { image in
            self.arrImages[sender.tag].1 = image
        }
    }
    
    func manageData(_ data: Bool) {
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
//        else if txtFldAsmName.text?.isEmptyCheck() == true {
//            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_ASM_NAME)
//            return false
//        } else if txtFldZoName.text?.isEmptyCheck() == true {
//            Proxy.shared.showSnackBar(message: "Please enter ZO Name")
//            return false
//        } 
//        else if arrImages.count != 5 {
//            Proxy.shared.showSnackBar(message: "There must be 5 store photos")
//            return false
//        }
        return true
    }
}
