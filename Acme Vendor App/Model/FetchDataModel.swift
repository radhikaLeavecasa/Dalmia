//
//  FetchDataModel.swift
//  Acme Vendor App
//
//  Created by acme on 04/06/24.
//

import UIKit
import ObjectMapper

struct FetchDataModel: Mappable {

    var asm: String?
    var city: String?
    var district: String?
    var gst: String?
    var height: String?
    var image: String?
    var lat: String?
    var long: String?
    var siteCode: Int?
    var siteIllumination: String?
    var state: String?
    var total: String?
    var vendor: String?
    var vendorContact: Int?
    var vendorEmail: String?
    var width: String?
    var zo: String?
    var zone: String?
    var siteName: String?
    
    init?(map: Map) {
        // Initialization can be empty
    }
    
    mutating func mapping(map: Map) {
        siteName <- map["site_name"]
        asm <- map["asm"]
        city <- map["city"]
        district <- map["district"]
        gst <- map["gst"]
        height <- map["height"]
        image <- map["image"]
        lat <- map["lat"]
        long <- map["long"]
        siteCode <- map["site_code"]
        siteIllumination <- map["site_illumination"]
        state <- map["state"]
        total <- map["total"]
        vendor <- map["vendor"]
        vendorContact <- map["vendor_contact"]
        vendorEmail <- map["vendor_email"]
        width <- map["width"]
        zo <- map["zo"]
        zone <- map["zone"]
    }
}
