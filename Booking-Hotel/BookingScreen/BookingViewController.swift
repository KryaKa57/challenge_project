//
//  BookingViewController.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit

class BookingViewController: UIViewController {
    var coordinator: BookingCoordinator?
    
    let bookingView = BookingView()
    let bookingViewModel: BookingViewModel
    let navigationManager = NavigationManager()

    override func loadView() {
        view = bookingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        addDelegates()
    }
    
    init(viewModel: BookingViewModel) {
        bookingViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDelegates() {
        bookingView.bookingInfoTableView.dataSource = self
        bookingView.bookingInfoTableView.delegate = self
        bookingView.bookingPriceTableView.dataSource = self
        bookingView.phoneNumberTextField.delegate = self
        bookingView.emailTextField.delegate = self
        
        bookingViewModel.delegate = self
        navigationManager.delegate = self
        
        bookingView.nextButton.addTarget(self, action: #selector(checkFields), for: .touchUpInside)
        bookingView.addButton.addTarget(self, action: #selector(addNewTourist), for: .touchUpInside)
    }
    
    func setNavigation() {
        navigationManager.setupNavigationBar(self, title: "Бронирование", hasLeftItem: true)
    }
    
    @objc func checkFields() {
        if !isAnyTextFieldEmpty(in: bookingView.allTouristStackView) {
            coordinator?.toFinalScreen()
        }
    }
    
    @objc func addNewTourist() {
        bookingViewModel.numberOfTourist += 1
        let newTourist = TouristStackView(textValue: "\(bookingViewModel.numberOfTourist.toString()) турист")
        bookingView.allTouristStackView.addArrangedSubview(newTourist)
        bookingView.layoutIfNeeded()
        
        newTourist.toggleDropdown()
        bookingView.layoutIfNeeded()
    }
    
    func isAnyTextFieldEmpty(in stackView: UIStackView) -> Bool {
        var hasEmptyTextField = false

        let textFields = stackView.getAllTextFields()
        for textField in textFields {
            textField.delegate = self
            if textField.text?.isEmpty ?? true {
                hasEmptyTextField = true
                textField.colorError()
            }
        }
        
        if (bookingView.isPhoneNumberFilled()) {
            hasEmptyTextField = true
            bookingView.phoneNumberTextField.colorError()
        }
        
        if !bookingViewModel.isValidEmail(bookingView.emailTextField.text ?? "") {
            hasEmptyTextField = true
            bookingView.emailTextField.colorError()
        }
        
        return hasEmptyTextField
    }
}

extension BookingViewController: APIRequestDelegate {
    func onSucceedRequest() {
        DispatchQueue.main.async {
            guard let bookingInfo = self.bookingViewModel.bookingInformation else { return }
            self.bookingView.configure(bookingInfo)
            self.bookingView.bookingInfoTableView.reloadData()
            self.bookingView.bookingPriceTableView.reloadData()
        }
    }
}

extension BookingViewController: NavigationManagerDelegate {
    func backButtonTapped() {
        coordinator?.popViewController()
    }
}

extension BookingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableView == bookingView.bookingInfoTableView) ? bookingViewModel.bookingInfoBlocks.count : bookingViewModel.bookingPriceBlocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableCell.reuseIdentifier, for: indexPath) as! InfoTableCell
            
        if tableView == bookingView.bookingPriceTableView {
            configurePriceCell(cell, forRowAt: indexPath)
        } else {
            configureInfoCell(cell, forRowAt: indexPath)
        }
            
        return cell
    }
    
    func configurePriceCell(_ cell: InfoTableCell, forRowAt indexPath: IndexPath) {
        let (leftText, rightText) = bookingViewModel.getPriceTexts(indexPath.row)
        cell.configure(leftText: leftText, rightText: rightText)
        cell.distanceItems()
        
        if indexPath.row == bookingViewModel.bookingPriceBlocks.count - 1 {
            cell.colorBlue()
        }
    }

    func configureInfoCell(_ cell: InfoTableCell, forRowAt indexPath: IndexPath) {
        let (leftText, rightText) = bookingViewModel.getInfoTexts(indexPath.row)
        cell.configure(leftText: leftText, rightText: rightText)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
}


extension BookingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        if textField == bookingView.phoneNumberTextField {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = bookingViewModel.format(phone: newString)
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(rgb: 0xF8F8F8)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == bookingView.emailTextField && !bookingViewModel.isValidEmail(textField.text ?? "") {
            bookingView.emailTextField.backgroundColor = UIColor(rgb: 0xEB5757, alpha: 0.15)
        }
    }
}
