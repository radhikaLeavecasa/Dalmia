//
//  ImagesOptionsVC.swift
//  Acme Vendor App
//
//  Created by acme on 04/11/24.
//

import UIKit

class ImagesOptionsVC: UIViewController {
    
    
    @IBOutlet var imgVwSite: [UIImageView]!
    @IBOutlet var btnSites: [UIButton]!
    
    typealias imgType = (_ imgStr: String) -> Void
    var imgTypeDelegate: imgType? = nil
    var images: [(String,UIImage)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for img in images {
            
            if img.0 == "Site Photograph" {
                imgVwSite[0].image = img.1
                btnSites[0].setTitle("Retake Site Photograph", for: .normal)
                self.btnSites[0].titleLabel?.font = UIFont(name: "DMSans18pt-Black", size: 14)

            } else if img.0 == "Far Shot" {
                imgVwSite[1].image = img.1
                btnSites[1].setTitle("Retake Far Shot", for: .normal)
                self.btnSites[1].titleLabel?.font = UIFont(name: "DMSans18pt-Black", size: 14)
            } else if img.0 == "Near Shot" {
              
                imgVwSite[2].image = img.1
                
                btnSites[2].setTitle("Retake Near Shot", for: .normal)
                self.btnSites[2].titleLabel?.font = UIFont(name: "DMSans18pt-Black", size: 14)
            } else if img.0 == "Left Angle" {
                imgVwSite[3].image = img.1
                btnSites[3].setTitle("Retake Left Angle", for: .normal)
                self.btnSites[3].titleLabel?.font = UIFont(name: "DMSans18pt-Black", size: 14)

            } else if img.0 == "Right Angle" {
                imgVwSite[4].image = img.1
                btnSites[4].setTitle("Retake Right Angle", for: .normal)
                self.btnSites[4].titleLabel?.font = UIFont(name: "DMSans18pt-Black", size: 14)

            }
        }
    }
    
    @IBAction func actionImages(_ sender: UIButton) {
        self.dismiss(animated: true) {
            guard let esign = self.imgTypeDelegate else { return }
            switch sender.tag {
            case 1:
                esign("Far Shot")
            case 2:
                esign("Near Shot")
            case 3:
                esign("Left Angle")
            case 4:
                esign("Right Angle")
            default:
                esign("Site Photograph")
            }
        }
    }
}
