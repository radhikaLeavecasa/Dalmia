//
//  ListingVM.swift
//  Acme Vendor App
//
//  Created by acme on 07/06/24.
//

import UIKit
import ObjectMapper

class ListingVM: NSObject {
    //MARK: - Variables
    var arrListing: [ListingModel]?
    var arrListing2: [ListingModel]?
    var arrState: [String]?
    var arrCity: [String]?
    var arrVendor: [String]?
    
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
    
    func asmSiteListingApi(_ api:Api, completion: @escaping(Bool, String) -> Void) {
        Proxy.shared.loadAnimation()
        arrListing = []
        WebService.callApi(api: api, method: .get, param: [:], header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    if let arrListing = data["data"] as? [[String: Any]] , let data2 = Mapper<ListingModel>().mapArray(JSONArray: arrListing) as [ListingModel]? {
                        self.arrListing?.append(contentsOf: data2)
                    }
                    completion(true, "")
                }
            } else {
                completion(false, msg)
            }
        }
    }
    
    func supervisorListingApi(_ api:Api, completion: @escaping(Bool, String) -> Void) {
        Proxy.shared.loadAnimation()
        arrListing = []
        WebService.callApi(api: api, method: .get, param: [:], header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    if let arrListing = data["data"] as? [[String: Any]] , let data2 = Mapper<ListingModel>().mapArray(JSONArray: arrListing) as [ListingModel]? {
                        self.arrListing?.append(contentsOf: data2)
                    }
                    completion(true, "")
                }
            } else {
                completion(false, msg)
            }
        }
    }
    
    
    func getStateVendorCityApi(_ api:Api, completion: @escaping(Bool, String) -> Void) {
        Proxy.shared.loadAnimation()
        arrState = []
        arrCity = []
        arrVendor = []
        WebService.callApi(api: api, method: .get, param: [:], header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    if let arrListing = data["data"] as? [[String: Any]] {
                        for item in arrListing {
                            if let state = item["state"] as? String {
                                self.arrState?.append(state)
                            }
                            if let state = item["city"] as? String {
                                self.arrCity?.append(state)
                            }
                            if let state = item["vendor"] as? String {
                                self.arrVendor?.append(state)
                            }
                        }
                    }
                }
                completion(true, "")
            } else {
                completion(false, msg)
            }
        }
    }
}
