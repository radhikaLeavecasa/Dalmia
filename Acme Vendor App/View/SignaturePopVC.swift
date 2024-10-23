//
//  SignaturePopVC.swift
//  Acme Vendor App
//
//  Created by acme on 07/06/24.
//

import UIKit
import AASignatureView

class SignaturePopVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var vwSignature: AASignatureView!
    //MARK: - Variables
    typealias eSign = (_ img: UIImage) -> Void
    var eSignDelegate: eSign? = nil
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - @IBActions
    @IBAction func actionClear(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.dismiss(animated: true) {
                if let image = self.vwSignature.signature {
                    guard let esign = self.eSignDelegate else { return }
                    esign(image)
                }
            }
        default:
            vwSignature.clear()
        }
    }
    @IBAction func actionDismiss(_ sender: Any) {
        self.dismiss(animated: false)
    }
}
