//
//  ProfileVM.swift
//  Acme Vendor App
//
//  Created by acme on 11/09/24.
//

import UIKit
import ObjectMapper

class ProfileVM: NSObject {
    var arrVendorList: [VendorListModule]?
    
    func vendorListApi(_ completion: @escaping (Bool,String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .userApi, method: .get, param: [:], header: true) { status, msg, response in
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
    
    func logoutApi(_ completion: @escaping (Bool,String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .logout, method: .post, param: [:], header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                completion(true, "")
            } else {
                completion(false, msg)
            }
        }
    }
}
