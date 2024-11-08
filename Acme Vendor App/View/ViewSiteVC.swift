//
//  ViewSiteVC.swift
//  Acme Vendor App
//
//  Created by acme on 25/10/24.
//

import UIKit

class ViewSiteVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var imgVw: UIImageView!
    //MARK: - Variables
    var image = String()
    var img = UIImage()
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if title != "imageForm" {
            imgVw.sd_setImage(with: URL(string: image), placeholderImage: .placeholderImage())
        } else {
            imgVw.image = img
        }
    }
    //MARK: - @IBActions
    @IBAction func actionClose(_ sender: Any) {
        popView()
    }
}
