//
//  ListingVC.swift
//  Acme Vendor App
//
//  Created by acme on 07/06/24.
//

import UIKit
import SDWebImage
import DropDown
import RSSelectionMenu

class ListingVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var cnstTblVwTop: NSLayoutConstraint!
    @IBOutlet weak var stackVwVendor: UIStackView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var txtFldCity: UITextField!
    @IBOutlet weak var vwFilterStack: UIStackView!
    @IBOutlet weak var txtFldVendor: UITextField!
    @IBOutlet weak var txtFldState: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var collVwSites: UICollectionView!
    
    //MARK: - Variable
    var selectedVendorStates = [String]()
    var arrVendorList2: [VendorListModule]?
    var selectedNames: [String] = []
    var selectedStates: [String] = []
    var selectedCities: [String] = []
    var viewModel = ListingVM()
    var selectedIndex = Int()
    var arrVendorList = [String]()
    var arrStateList = [String]()
    var arrStateList2 = [String]()
    var arrCityList = [String]()
    var arrCityList2 = [String]()
    let dropDown = DropDown()
    let homeViewModel = HomeVM()
    var arrVendorState = [String]()
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
    
        lblType.text = "\(Cookies.userInfo()?.type.capitalized ?? "") - \(Cookies.userInfo()?.name ?? "")"
        homeViewModel.vendorListApi { val, msg in
            if val {
                self.arrVendorList2 = self.homeViewModel.arrVendorList
                for i in self.homeViewModel.arrVendorList ?? [] {
                    self.arrVendorList.append(i.name ?? "")
                }
            } else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                } else {
                    Proxy.shared.showSnackBar(message: msg)
                }
            }
        }
        
        homeViewModel.reminderApi { val, msg in
            if val {
                if let vc = ViewControllerHelper.getViewController(ofType: .ReminderPopVC, StoryboardName: .Main) as? ReminderPopVC {
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    vc.arrCode = self.homeViewModel.arrCode ?? []
                    vc.remarksDelegate = { code in
                        let vc = ViewControllerHelper.getViewController(ofType: .AdminHomeVC, StoryboardName: .Main) as! AdminHomeVC
                        vc.code = code
                        self.pushView(vc: vc, title: "Reminder")
                    }
                    self.present(vc, animated: true)
                }
            } else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                } else {
                    Proxy.shared.showSnackBar(message: msg)
                }
            }
        }
        cnstTblVwTop.constant = Cookies.userInfo()?.type == "asm" || Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "racce" || Cookies.userInfo()?.type == "zo" ? 0 : 20
        vwFilterStack.isHidden = Cookies.userInfo()?.type == "asm" || Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "racce" || Cookies.userInfo()?.type == "zo"
        stackVwVendor.isHidden = Cookies.userInfo()?.type == "asm" || Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "racce" || Cookies.userInfo()?.type == "zo"
        if Cookies.userInfo()?.type == "asm" || Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "outsource" {
            viewModel.asmSiteListingApi(Cookies.userInfo()?.type == "asm" ? .asmProjectList(Cookies.userInfo()?.name ?? "") : Cookies.userInfo()?.type == "vendor" ? .vendorProjectList(Cookies.userInfo()?.name ?? "") : .outsourceProjectList(Cookies.userInfo()?.name ?? "")) { val, msg in
                if val {
                    if self.viewModel.arrListing?.count == 0 {
                        self.lblNoDataFound.isHidden = false
                        self.collVwSites.isHidden = true
                    } else {
                        self.viewModel.arrListing2 = self.viewModel.arrListing
                        self.viewModel.arrListing?.forEach({ val in
                            if let state = val.state, !self.arrStateList.contains(state) {
                                self.arrStateList.append(state)
                            }
                            if let city = val.city, !self.arrCityList.contains(city) {
                                self.arrCityList.append(city)
                            }
                        })
                        self.arrStateList2 = self.arrStateList
                        self.arrCityList2 = self.arrCityList
                        self.lblNoDataFound.isHidden = true
                        self.collVwSites.isHidden = false
                    }
                    self.collVwSites.reloadData()
                } else {
                    if msg == CommonError.INTERNET {
                        Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                    } else {
                        Proxy.shared.showSnackBar(message: msg)
                    }
                }
            }
        } else if Cookies.userInfo()?.type == "admin" || Cookies.userInfo()?.type == "client" {
            btnAdd.isHidden = Cookies.userInfo()?.type == "client"
            viewModel.supervisorListingApi(Cookies.userInfo()?.type == "admin" ? .adminProjectListing : .clientProjectListing) { val, msg in
                if val {
                    if self.viewModel.arrListing?.count == 0 {
                        self.lblNoDataFound.isHidden = false
                        self.collVwSites.isHidden = true
                    } else {
                        self.viewModel.arrListing2 = self.viewModel.arrListing
                        self.lblNoDataFound.isHidden = true
                        self.collVwSites.isHidden = false
                        self.viewModel.arrListing?.forEach({ val in
                            if let state = val.state, !self.arrStateList.contains(state) {
                                self.arrStateList.append(state)
                            }
                            if let city = val.city, !self.arrCityList.contains(city) {
                                self.arrCityList.append(city)
                            }
                        })
                    }
                    self.arrStateList2 = self.arrStateList
                    self.arrCityList2 = self.arrCityList
                    self.collVwSites.reloadData()
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
    
    @IBAction func actionAdd(_ sender: Any) {
        let vc = ViewControllerHelper.getViewController(ofType: .AdminHomeVC, StoryboardName: .Main) as! AdminHomeVC
        self.pushView(vc: vc)
    }
    @IBAction func actionLogout(_ sender: Any) {
        
        let vc = ViewControllerHelper.getViewController(ofType: .ProfileVC, StoryboardName: .Main) as! ProfileVC
        self.pushView(vc: vc)
    }
    @IBAction func actionResetFilter(_ sender: Any) {
        txtFldCity.text = ""
        txtFldState.text = ""
        txtFldVendor.text = ""
        selectedNames = []
        selectedStates = []
        selectedCities = []
        self.viewModel.arrListing = self.viewModel.arrListing2
        collVwSites.reloadData()
    }
}

extension ListingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.arrListing?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCVC", for: indexPath) as! SiteCVC
        cell.lblShopName.text = "\(viewModel.arrListing?[indexPath.row].code != nil ? "Name: \(viewModel.arrListing?[indexPath.row].siteName ?? "")\nCode: \(viewModel.arrListing?[indexPath.row].code ?? "")" : viewModel.arrListing?[indexPath.row].retailName ?? "")"
        cell.imgVwSite.sd_setImage(with: URL(string: "\(imageBaseUrl)\(viewModel.arrListing?[indexPath.row].image ?? "")"), placeholderImage: .placeholderImage())
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collVwSites.frame.size.width/2, height: self.collVwSites.frame.size.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ViewControllerHelper.getViewController(ofType: .SiteDetailVC, StoryboardName: .Main) as! SiteDetailVC
        vc.siteDetail = viewModel.arrListing?[indexPath.row]
        self.pushView(vc: vc)
    }
}

extension ListingVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtFldState {
            
            viewModel.getStateVendorCityApi(.getStateByCityVendor(txtFldCity.text == "" ? "null" : txtFldCity.text!, vendor: txtFldVendor.text == "" ? "null" : txtFldVendor.text!)) { val, msg in
                if val {
                    let menu = RSSelectionMenu(selectionStyle: .multiple, dataSource: self.viewModel.arrState ?? []) { (cell, name, indexPath) in
                        cell.textLabel?.text = name
                    }
                    
                    menu.setSelectedItems(items: self.selectedStates) { (name, index, selected, selectedItems) in
                        self.selectedStates = selectedItems
                        self.txtFldState.text = selectedItems.joined(separator: ",")
                        self.filterSite(selectedStates: self.selectedStates, selectedCities: self.selectedCities, selectedNames: self.selectedNames)
                    }
                    menu.show(style: .popover(sourceView: textField, size: CGSize(width: 200, height: 220), arrowDirection: .up, hideNavBar: true), from: self)
                }
            }
            return false
        } else if textField == txtFldVendor {
            
            viewModel.getStateVendorCityApi(.getVendorByStateCity(txtFldState.text == "" ? "null" : txtFldState.text!, city: txtFldCity.text != "" ? "null" : txtFldCity.text!)) { val, msg in
                if val {
                    let menu = RSSelectionMenu(selectionStyle: .multiple, dataSource: self.viewModel.arrVendor ?? []) { (cell, name, indexPath) in
                        cell.textLabel?.text = name
                    }
                    
                    menu.setSelectedItems(items: self.selectedNames) { (name, index, selected, selectedItems) in
                        self.selectedNames = selectedItems
                        self.txtFldVendor.text = selectedItems.joined(separator: ",")
                        self.filterSite(selectedStates: self.selectedStates, selectedCities: self.selectedCities, selectedNames: self.selectedNames)
                    }
                    menu.show(style: .popover(sourceView: textField, size: CGSize(width: 200, height: 220), arrowDirection: .up, hideNavBar: true), from: self)
                    
                }
            }
            return false
        } else if textField == txtFldCity {
            viewModel.getStateVendorCityApi(.getCityByStateVendor(txtFldState.text == "" ? "null" : txtFldState.text!, vendor: txtFldVendor.text == "" ? "null" : txtFldVendor.text!)) { val, msg in
                if val {
                    let menu = RSSelectionMenu(selectionStyle: .multiple, dataSource: self.viewModel.arrCity ?? []) { (cell, name, indexPath) in
                        cell.textLabel?.text = name
                    }
                    
                    menu.setSelectedItems(items: self.selectedCities) { (name, index, selected, selectedItems) in
                        self.selectedCities = selectedItems
                        self.txtFldCity.text = selectedItems.joined(separator: ",")
                        self.filterSite(selectedStates: self.selectedStates, selectedCities: self.selectedCities, selectedNames: self.selectedNames)
                    }
                    menu.show(style: .popover(sourceView: textField, size: CGSize(width: 200, height: 220), arrowDirection: .up, hideNavBar: true), from: self)

                }
            }
            return false
        } else {
            return true
        }
    }
    
    func filterSite(selectedStates: [String], selectedCities: [String], selectedNames: [String]) {
        self.viewModel.arrListing = self.viewModel.arrListing2?.filter { item in
            // Check if the item matches any of the selected states, cities, and names
            let stateMatches = selectedStates.isEmpty || selectedStates.contains(item.state ?? "")
            let cityMatches = selectedCities.isEmpty || selectedCities.contains(item.city ?? "")
            let nameMatches = selectedNames.isEmpty || selectedNames.contains(item.vendorName ?? "")

            return stateMatches && cityMatches && nameMatches
        } ?? []

        collVwSites.reloadData()
    }
}

extension ListingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrVendorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VendorListTVC", for: indexPath) as! VendorListTVC
        cell.lblVendorName.text = homeViewModel.arrVendorList?[indexPath.row].name
        cell.lblState.text = homeViewModel.arrVendorList?[indexPath.row].state
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewControllerHelper.getViewController(ofType: .ProfileVC, StoryboardName: .Main) as! ProfileVC
        vc.vendorData = homeViewModel.arrVendorList?[indexPath.row]
        self.pushView(vc: vc, title: "vendor")
    }
}
