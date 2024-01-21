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
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDelegates() {
        roomView.collectionView.dataSource = self
        roomView.collectionView.delegate = self
        roomViewModel.delegate = self
        navigationManager.delegate = self
    }
    
    func setNavigation() {
        guard let title = roomViewModel.title else { return }
        navigationManager.setupNavigationBar(self, title: title, hasLeftItem: true)
    }
}

extension RoomViewController: APIRequestDelegate {
    func onSucceedRequest() {
        DispatchQueue.main.async {
            self.roomView.collectionView.reloadData()
        }
    }
}

extension RoomViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomViewModel.roomsInformation?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomCell.reuseIdentifier, for: indexPath) as! RoomCell
        guard let roomInfo = roomViewModel.roomsInformation, indexPath.row < roomInfo.count else { return cell }
        cell.configure(roomInfo[indexPath.row])
        cell.nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 550)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    @objc func goToNextScreen() {
        coordinator?.toBookingScreen()
    }
}

extension RoomViewController: NavigationManagerDelegate {
    func backButtonTapped() {
        coordinator?.popViewController()
    }
}

