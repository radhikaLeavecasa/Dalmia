//
//  SiteHistoryVC.swift
//  Acme Vendor App
//
//  Created by acme on 20/09/24.
//

import UIKit

class SiteHistoryVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var tblVwHistory: UITableView!
    @IBOutlet weak var lblHeaderCode: UILabel!
    //MARK: - Variables
    var code = String()
    var arrUpdates: ListingModel?
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHeaderCode.text = code
      
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
}

extension SiteHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrUpdates?.histories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VendorListTVC", for: indexPath) as! VendorListTVC
        
        cell.lblVendorName.text = "Last updated on: \(convertDateFormat(date: arrUpdates?.histories?[indexPath.row].createdAt ?? "", getFormat: "EEE, dd MMM, yy", dateFormat: "yyyy-MM-dd'T'HH:mm:ss.000000Z")) at \(convertDateFormat(date: arrUpdates?.histories?[indexPath.row].createdAt ?? "", getFormat: "hh:mm", dateFormat: "yyyy-MM-dd'T'HH:mm:ss.000000Z"))"
        cell.imgVwSite.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrUpdates?.histories?[indexPath.row].image ?? "")"), placeholderImage: .placeholderImage())
        return cell
    }
}
