//
//  RoomViewController.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit

class RoomViewController: UIViewController {
    var coordinator: RoomCoordinator?
    
    let roomView = RoomView()
    let roomViewModel: RoomViewModel
    let navigationManager = NavigationManager()

    override func loadView() {
        view = roomView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        addDelegates()
    }
    
    init(viewModel: RoomViewModel) {
        roomViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
    
    func addDelegates() { // Добавление делегатов к контроллеру
        roomView.collectionView.dataSource = self
        roomView.collectionView.delegate = self
        roomViewModel.delegate = self
        navigationManager.delegate = self
    }
    
    func setNavigation() {  // Установка элементов навигации
        guard let title = roomViewModel.title else { return }
        navigationManager.setupNavigationBar(self, title: title, hasLeftItem: true) // Вызов метода для настройки элементов
    }
}

extension RoomViewController: APIRequestDelegate { // Делегаты при обработки запроса
    func onSucceedRequest() { // Метод при успешном запросе
        DispatchQueue.main.async {
            self.roomView.collectionView.reloadData() // Обновляем данные в коллекции
        }
    }
    
    func onFailedRequest(errorMessage: String) { // Метод при получении ошибки в запросе
        DispatchQueue.main.async {
            PopupManager.showLoginFailurePopUp(on: self.view, message: "\(TextConstants.failedRequestMessage).\(errorMessage)")
            // Вывод модуля с текстом ошибки
        }
    }
}

extension RoomViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Делегаты и сорсы для коллекции видов комнат
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Количество секции в коллекции
        return roomViewModel.roomsInformation?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Инициализация и настройка ячеек коллекции
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomCell.reuseIdentifier, for: indexPath) as! RoomCell
        guard let roomInfo = roomViewModel.roomsInformation, indexPath.row < roomInfo.count else { return cell }
        cell.configure(roomInfo[indexPath.row])
        // Добавляем таргет для перехода на следующий экран
        cell.nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Установка размера ячейки
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 550)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Установка отступов для секции
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    @objc func goToNextScreen() {
        coordinator?.toBookingScreen() // Вызов метода коордиантора для перехода на страницу "Бронирование"
    }
}

extension RoomViewController: NavigationManagerDelegate {
    func backButtonTapped() {
        coordinator?.popViewController() // Вызов метода коордиантора для перехода на предыдущую страницу
    }
}

