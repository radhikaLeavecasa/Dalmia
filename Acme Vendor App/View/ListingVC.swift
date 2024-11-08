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
    @IBOutlet weak var collVwOptions: UICollectionView!
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
    @IBOutlet weak var collVwHeightTopOptions: NSLayoutConstraint!
    @IBOutlet weak var constCollVwOptionTop: NSLayoutConstraint!
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
    var arrHeader = ["All","Pending","Approved","Rejected", "RHM Rejected"]
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
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
                } else if msg != "No sites found" {
                    Proxy.shared.showSnackBar(message: msg)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedIndex = 0
        collVwHeightTopOptions.constant = Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "rhm" ? 45 : 0
        collVwOptions.isHidden = Cookies.userInfo()?.type != "vendor" && Cookies.userInfo()?.type != "rhm"
        constCollVwOptionTop.constant = Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "rhm" ? 10 : 0
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
        
        cnstTblVwTop.constant = Cookies.userInfo()?.type == "asm" || Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "racce" || Cookies.userInfo()?.type == "zo" || Cookies.userInfo()?.type == "vendor_executive" ? 0 : 20
        vwFilterStack.isHidden = Cookies.userInfo()?.type == "asm" || Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "racce" || Cookies.userInfo()?.type == "zo" || Cookies.userInfo()?.type == "vendor_executive"
        stackVwVendor.isHidden = Cookies.userInfo()?.type == "asm" || Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "racce" || Cookies.userInfo()?.type == "zo" || Cookies.userInfo()?.type == "vendor_executive"
        if Cookies.userInfo()?.type == "asm" || Cookies.userInfo()?.type == "vendor" || Cookies.userInfo()?.type == "outsource" || Cookies.userInfo()?.type == "vendor_executive" {
            
            btnAdd.isHidden = Cookies.userInfo()?.type == "zo" || Cookies.userInfo()?.type == "asm"
            
            viewModel.asmSiteListingApi(Cookies.userInfo()?.type == "asm" ? .asmProjectList(Cookies.userInfo()?.state ?? "") : Cookies.userInfo()?.type == "vendor" ? .vendorProjectList(Cookies.userInfo()?.name ?? "") : Cookies.userInfo()?.type == "vendor_executive" ? .vendorExecutiveProjectList(Cookies.userInfo()?.email ?? "") : .outsourceProjectList(Cookies.userInfo()?.zone ?? "")) { val, msg in
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
        } else if Cookies.userInfo()?.type == "admin" || Cookies.userInfo()?.type == "client" || Cookies.userInfo()?.type == "rhm" {
            btnAdd.isHidden = Cookies.userInfo()?.type == "client" || Cookies.userInfo()?.type == "rhm"
            viewModel.supervisorListingApi(Cookies.userInfo()?.type == "admin" ? .adminProjectListing : Cookies.userInfo()?.type == "client" ? .clientProjectListing : .rhmClientProjectListing(Cookies.userInfo()?.zone ?? "")) { val, msg in
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
        collectionView == collVwOptions ? Cookies.userInfo()?.type == "vendor" ? arrHeader.count : arrHeader.count-1 : viewModel.arrListing?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collVwOptions {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCVC", for: indexPath) as! OptionsCVC
            cell.vwTitle.backgroundColor = indexPath.row == selectedIndex ? .APP_BLUE_CLR : .APP_GRAY_CLR
            cell.lblTitle.text = arrHeader[indexPath.row]
            cell.lblTitle.textColor = indexPath.row == selectedIndex ? .APP_GRAY_CLR : .APP_BLUE_CLR
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCVC", for: indexPath) as! SiteCVC
            cell.lblShopName.text = "\(viewModel.arrListing?[indexPath.row].code != nil ? "Name: \(viewModel.arrListing?[indexPath.row].siteName ?? "")\nCode: \(viewModel.arrListing?[indexPath.row].code ?? "")" : viewModel.arrListing?[indexPath.row].retailName ?? "")"
            if viewModel.arrListing?[indexPath.row].image != "" && viewModel.arrListing?[indexPath.row].image != nil {
                cell.imgVwSite.sd_setImage(with: URL(string: "\(imageBaseUrl)\(viewModel.arrListing?[indexPath.row].image ?? "")"), placeholderImage: .placeholderImage())
            } else {
                cell.imgVwSite.sd_setImage(with: URL(string: "\(imageBaseUrl)\(viewModel.arrListing?[indexPath.row].newImage ?? "")"), placeholderImage: .placeholderImage())
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collVwOptions {
            
            let text = arrHeader[indexPath.row]
                    let font = UIFont.systemFont(ofSize: 17) // Adjust font size as needed
                    let maxWidth = collectionView.frame.width - 20 // Leave some padding
                    let maxSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
                    
                    // Calculate the size of the text
                    let size = (text as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).size
                    
                    // Return the calculated size with some padding
                   // return CGSize(width: size.width + 20, height: size.height + 20)
            
            
            return CGSize(width: size.width + 30, height: self.collVwOptions.frame.size.height)
        } else {
            return CGSize(width: self.collVwSites.frame.size.width/2, height: self.collVwSites.frame.size.width/2)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collVwOptions {
            selectedIndex = indexPath.row
            
            switch Cookies.userInfo()?.type {
            case "vendor":
                if indexPath.row != 0 && indexPath.row != 4 {
                    viewModel.vendorSiteListing(indexPath.row == 1 ? .vendorPendingSite(Cookies.userInfo()?.name ?? "") : indexPath.row == 2 ? .vendorApprovedSite(Cookies.userInfo()?.name ?? "") : .vendorRejectedSite(Cookies.userInfo()?.name ?? "")) { val, msg in
                        if val {
                            if self.viewModel.arrListing?.count == 0 {
                                self.lblNoDataFound.isHidden = false
                                self.collVwSites.isHidden = true
                            } else {
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
                } else if indexPath.row == 0 {
                    viewModel.asmSiteListingApi(.vendorProjectList(Cookies.userInfo()?.name ?? "")) { val, msg in
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
                } else {
                    viewModel.rhmRejectedList(.rhmRejectedList(Cookies.userInfo()?.name ?? "")) { val, msg in
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
                }
            case "rhm":
                if indexPath.row != 0 {
                    viewModel.vendorSiteListing(indexPath.row == 1 ? .rhmPendingSite(Cookies.userInfo()?.zone ?? "") : indexPath.row == 2 ? .rhmApprovedSite(Cookies.userInfo()?.zone ?? "") : .rhmRejectedSite(Cookies.userInfo()?.zone ?? "")) { val, msg in
                        if val {
                            if self.viewModel.arrListing?.count == 0 {
                                self.lblNoDataFound.isHidden = false
                                self.collVwSites.isHidden = true
                            } else {
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
                } else {
                    viewModel.asmSiteListingApi(.rhmClientProjectListing(Cookies.userInfo()?.zone ?? "")) { val, msg in
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
                }
            default:
                break
            }
            collVwOptions.reloadData()

        } else {
            let vc = ViewControllerHelper.getViewController(ofType: .SiteDetailVC, StoryboardName: .Main) as! SiteDetailVC
            vc.siteDetail = viewModel.arrListing?[indexPath.row]
            self.pushView(vc: vc)
        }
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
