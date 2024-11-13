//
//  RejectionVC.swift
//  Acme Vendor App
//
//  Created by acme on 11/06/24.
//

import UIKit
import IQKeyboardManagerSwift

class ReminderPopVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var collVwVCodes: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    //MARK: - Variables
    var arrCode = [(String,String)]()
    //MARK: - Variables
    typealias remarks = (_ code: String, _ id: String) -> Void
    var remarksDelegate: remarks? = nil
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - @IBActions
    @IBAction func actionDone(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ReminderPopVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrCode.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCVC", for: indexPath) as! SiteCVC
        cell.btnCodeName.setTitle(arrCode[indexPath.row].0, for: .normal)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collVwVCodes.frame.width/3 - 5, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let code = self.remarksDelegate else { return }
        code(arrCode[indexPath.row].0, arrCode[indexPath.row].1)
        dismiss(animated: true)
    }
}
