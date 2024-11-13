//
//  HomeVM.swift
//  Acme Vendor App
//
//  Created by acme on 04/06/24.
//

import UIKit
import Alamofire
import ObjectMapper

class HomeVM: NSObject {
    
    var homeModel: FetchDataModel?
    var arrVendorList: [VendorListModule]?
    var arrCode: [(String, String)]?
    
    func fetchApi(_ code: String, id: String, _ completion: @escaping (Bool,String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .fetchApi(code,userID: id), method: .get, param: [:], header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    if let data2 = data["data"] as? [String:Any] {
                        self.homeModel = FetchDataModel(JSON: data2)
                        completion(true, "")
                    }
                }
            } else {
                completion(false, msg)
            }
        }
    }
    
    func vendorListApi(_ completion: @escaping (Bool,String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .vendorList, method: .get, param: [:], header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    if let arrListing = data["data"] as? [[String: Any]] , let data2 = Mapper<VendorListModule>().mapArray(JSONArray: arrListing) as [VendorListModule]? {
                        self.arrVendorList = data2
                        completion(true, "")
                    }
                }
            } else {
                completion(false, msg)
            }
        }
    }
    
    func reminderApi(_ completion: @escaping (Bool, String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .notification(Cookies.userInfo()?.name ?? ""), method: .get, param: [:], header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            
            if status {
                guard let data = response as? [String: Any],
                      let arrListing = data["data"] as? [[String: Any]] else {
                    completion(false, "Invalid data format")
                    return
                }
                
                self.arrCode = [] // Clear previous codes
                
                for item in arrListing {
                    if let code = item["code"] as? String, let id = item["id"] as? Int {
                        self.arrCode?.append((code,"\(id)"))
                    }
                }
                
                // Call completion only once, after processing all items
                completion(true, "")
            } else {
                completion(false, msg)
            }
        }
    }
    
    func uploadSiteDetails(param:[String:Any],dictImage: [String: UIImage], _ completion: @escaping (Bool,String) -> Void){
        Proxy.shared.loadAnimation()
        WebService.uploadImageWithURL(api: .uploadSiteDetails, dictImage: dictImage, parameter: param) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    completion(true, msg)
                }
            }else{
                completion(false, msg)
            }
        }
    }
}
