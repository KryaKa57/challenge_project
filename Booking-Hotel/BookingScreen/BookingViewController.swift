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
        initializeHideKeyboard()
    }
    
    init(viewModel: BookingViewModel) {
        bookingViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
    
    // Добавление делегатов к контроллеру и действий для кнопок
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
    
    func setNavigation() { // Установка элементов навигации
        navigationManager.setupNavigationBar(self, title: TextConstants.secondTitleText, hasLeftItem: true)
    }
    
    @objc func checkFields() { // Проверка на заполнение данных о туристе
        if !isAnyTextFieldEmpty(in: bookingView.allTouristStackView) {
            coordinator?.toFinalScreen()
        }
    }
    
    @objc func addNewTourist() { // Добавление нового туриста
        bookingViewModel.numberOfTourist += 1 // Увеличиваем количество туристов
        let newTourist = TouristStackView(textValue: "\(bookingViewModel.numberOfTourist.toString())") // Создаем вьюшку для туриста
        bookingView.allTouristStackView.addArrangedSubview(newTourist) // Добавляем новую вьюшка в общий стак туристов
        bookingView.layoutIfNeeded() // Обновляем вид экрана, размещая новую вьюшку
        
        newTourist.toggleDropdown() // Переключить выпадающий списокть
        bookingView.layoutIfNeeded() // Повторно обновляем вид экрана
    }
    
    func isAnyTextFieldEmpty(in stackView: UIStackView) -> Bool {
        // Проверка на пустоту всех текстовых полей
        var hasEmptyTextField = false
        
        // Проверка текстовых полей внутри стака
        let textFields = stackView.getAllTextFields() // Получение списка текстовых полей со стака
        for textField in textFields {
            if textField.text?.isEmpty ?? true {
                hasEmptyTextField = true // Если текст в поле пуст, то указываем, что меняем параметр на true
                textField.colorError() // Закрашиваем поле в красный цвет
            }
        }
        
        // Проверка заполненности номера телефона
        if !bookingView.isPhoneNumberFilled() {
            hasEmptyTextField = true // Если текст в поле пуст, то указываем, что меняем параметр на true
            bookingView.phoneNumberTextField.colorError() // Закрашиваем поле в красный цвет
        }
        
        // Проверка валидности электронной почты
        if !bookingViewModel.isValidEmail(bookingView.emailTextField.text ?? "") {
            hasEmptyTextField = true // Если текст в поле не прошла валидацию, то указываем, что меняем параметр на true
            bookingView.emailTextField.colorError() // Закрашиваем поле в красный цвет
        }
        
        return hasEmptyTextField
    }
    
    func initializeHideKeyboard() {
        // Инициализация жеста нажатия
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
        
    @objc func dismissMyKeyboard(){
        // Метод для скрытия клавиатуры при вызове жеста
        view.endEditing(true)
    }
}

extension BookingViewController: APIRequestDelegate { // Делегаты при обработки запроса
    func onSucceedRequest() { // Метод при удачном запросе
        DispatchQueue.main.async {
            guard let bookingInfo = self.bookingViewModel.bookingInformation else { return }
            self.bookingView.configure(bookingInfo) // Настройка вида с обновленными данными
            self.bookingView.bookingInfoTableView.reloadData() // Обновляем данные в таблицах
            self.bookingView.bookingPriceTableView.reloadData()
        }
    }
    
    func onFailedRequest(errorMessage: String) { // Метод при получении ошибки в запросе
        DispatchQueue.main.async {
            PopupManager.showLoginFailurePopUp(on: self.view, message: "\(TextConstants.failedRequestMessage).\(errorMessage)")
            // Вывод модуля с текстом ошибки
        }
    }
}

extension BookingViewController: NavigationManagerDelegate {
    // Делегат с кнопки навигации для перехода на предыдущую страницу
    func backButtonTapped() {
        coordinator?.popViewController()
    }
}

extension BookingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Количество рядов секции
        return (tableView == bookingView.bookingInfoTableView) ? bookingViewModel.bookingInfoBlocks.count : bookingViewModel.bookingPriceBlocks.count
        // Две таблицы в одном контроллере, поэтому делим их через проверку с сравнением
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // инициализация и настройка ячеек
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableCell.reuseIdentifier, for: indexPath) as! InfoTableCell
        
        // Определение, для какой таблицы настраивается ячейка
        if tableView == bookingView.bookingPriceTableView {
            configurePriceCell(cell, forRowAt: indexPath) // Настройка ячейки для таблицы цен
        } else {
            configureInfoCell(cell, forRowAt: indexPath) // Настройка ячейки для таблицы с информацией
        }
            
        return cell
    }
    
    func configurePriceCell(_ cell: InfoTableCell, forRowAt indexPath: IndexPath) {
        // Инициализация ячейки с ценой и их передача для конфигурации
        let (leftText, rightText) = bookingViewModel.getPriceTexts(indexPath.row)
        cell.configure(leftText: leftText, rightText: rightText)
        cell.distanceItems()
        
        // Проверка, является ли ячейка последней в таблице цен и краска на синий цвет
        if indexPath.row == bookingViewModel.bookingPriceBlocks.count - 1 {
            cell.colorBlue()
        }
    }

    func configureInfoCell(_ cell: InfoTableCell, forRowAt indexPath: IndexPath) {
        // Инициализация ячейки с информацией и их передача для конфигурации
        let (leftText, rightText) = bookingViewModel.getInfoTexts(indexPath.row)
        cell.configure(leftText: leftText, rightText: rightText)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // Оценочная высота ячейки
        return 36
    }
}


extension BookingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let isFilled = !text.contains("*")
        if textField == bookingView.phoneNumberTextField {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = bookingViewModel.format(phone: newString, isFilled: isFilled)
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = Color.background().getUIColor()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == bookingView.emailTextField && !bookingViewModel.isValidEmail(textField.text ?? "") {
            textField.backgroundColor = Color.error().getUIColor()
        }
        if textField == bookingView.phoneNumberTextField && !bookingView.isPhoneNumberFilled() {
            textField.backgroundColor = Color.error().getUIColor()
        }
    }
}
