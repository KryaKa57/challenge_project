//
//  BookingViewController.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit

class BookingViewController: UIViewController {
    let bookingView: BookingView
    let bookingViewModel: BookingViewModel
    let navigationManager = NavigationManager()

    override func loadView() {
        view = bookingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        bookingViewModel.getInfo()
        addDelegates()
    }
    
    init(view: BookingView, viewModel: BookingViewModel) {
        bookingViewModel = viewModel
        bookingView = view
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
            navigationController?.pushViewController(FinalViewController(view: FinalView()), animated: true)
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

        for subview in stackView.subviews {
            if let textField = subview as? UITextField {
                textField.delegate = self
                if textField.text?.isEmpty ?? true {
                    hasEmptyTextField = true
                    textField.backgroundColor = UIColor(rgb: 0xEB5757, alpha: 0.15)
                }
            } else if let nestedStackView = subview as? UIStackView {
                if isAnyTextFieldEmpty(in: nestedStackView) {
                    hasEmptyTextField = true
                }
            }
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
        navigationController?.popViewController(animated: true)
    }
}

extension BookingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableView == bookingView.bookingInfoTableView) ? bookingViewModel.bookingInfoBlocks.count : bookingViewModel.bookingPriceBlocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let block = (tableView == bookingView.bookingInfoTableView) ? bookingViewModel.bookingInfoBlocks : bookingViewModel.bookingPriceBlocks
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableCell.reuseIdentifier, for: indexPath) as! InfoTableCell
        let leftText = block[indexPath.row].title
        let rightText = block[indexPath.row].description
        cell.configure(leftText: leftText, rightText: rightText)
        if tableView == bookingView.bookingPriceTableView {
            cell.distanceItems()
            
            if indexPath.row == bookingViewModel.bookingPriceBlocks.count - 1 {
                cell.rightTextLabel.textColor = UIColor(rgb: 0x0D72FF)
                cell.rightTextLabel.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            }
        }
        return cell
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
            textField.text = format(phone: newString)
        } else {
            return true
        }
        
        return false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(rgb: 0xF8F8F8)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == bookingView.emailTextField {
            if !isValidEmail(textField.text ?? "") {
                bookingView.emailTextField.backgroundColor = UIColor(rgb: 0xEB5757, alpha: 0.15)
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func format(phone: String) -> String {
        var mask = "(***) ***-**-**"
        var result = "+7 "
        
        let charactersToRemove: Set<Character> = ["(", ")", "*", "-", " "]
        var newString = String(String(phone.dropFirst(2)).filter{!charactersToRemove.contains($0)})

        if (phone.count == mask.count + 2) {
            newString = String(newString.dropLast())
        }
        
        let numbers = newString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "*" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        mask = String(mask.dropFirst(result.count - 3))
        return result + mask
    }
}
