//
//  HotelViewController.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit

class HotelViewController: UIViewController {
    private let hotelView = HotelView()
    private let hotelViewModel: HotelViewModel
    var coordinator: HotelCoordinator?

    override func loadView() {
        view = hotelView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = TextConstants.firstTitleText
        
        addDelegates()
        addTarget()
    }
    
    init(viewModel: HotelViewModel) {
        hotelViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
    
    // Добавление делегатов к контроллеру
    func addDelegates() {
        hotelView.scrollView.delegate = self
        hotelViewModel.delegate = self
        hotelView.moreInfoTabelView.dataSource = self
        hotelView.moreInfoTabelView.delegate = self
    }
   
    // Добавление таргета для кнопки с переходом на следующий экран
    func addTarget() {
        hotelView.nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
    }
    
    @objc func goToNextScreen() {
        coordinator?.toRoomScreen() // Вызов функции координатора для перехода на экран "Room"
    }
}

extension HotelViewController: UIScrollViewDelegate { // Делегат для скролинга карусели фотографии
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.hotelView.pageControl.currentPage = pageIndex
    }
}

extension HotelViewController: APIRequestDelegate { // Делегаты при обработки запроса
    func onSucceedRequest() { // Метод при удачном запросе
        DispatchQueue.main.async {
            guard let hotelInfo = self.hotelViewModel.hotelInformation else { return }
            self.hotelView.configure(hotelInfo)
        }
    }
    
    func onFailedRequest(errorMessage: String) { // Метод при получении ошибки в запросе
        DispatchQueue.main.async {
            PopupManager.showLoginFailurePopUp(on: self.view, message: "\(TextConstants.failedRequestMessage).\(errorMessage)")
            // Вывод модуля с текстом ошибки
        }
    }
}

extension HotelViewController: UITableViewDataSource, UITableViewDelegate { // Делегаты и сорсы таблицы с подробными данным об отеле
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // кол-во рядом в таблице
        return hotelViewModel.moreInformation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // инициализация и настройка ячеек
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreInfoCell.reuseIdentifier, for: indexPath) as! MoreInfoCell
        cell.configure(hotelViewModel.moreInformation[indexPath.row])
        if indexPath.row == hotelViewModel.moreInformation.count - 1 { // Добавляем разделяющую линию после каждой ячейки, кроме последней
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65 // Высота ячейки
    }
}
