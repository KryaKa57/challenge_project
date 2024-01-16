//
//  HotelViewController.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit

class HotelViewController: UIViewController {
    let hotelView: HotelView
    let hotelViewModel: HotelViewModel

    
    override func loadView() {
        view = hotelView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Отель"
        
        hotelViewModel.getInfo()
        addDelegates()
        addTarget()
    }
    
    init(view: HotelView, viewModel: HotelViewModel) {
        hotelViewModel = viewModel
        hotelView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDelegates() {
        hotelView.scrollView.delegate = self
        hotelViewModel.delegate = self
        hotelView.moreInfoTabelView.dataSource = self
        hotelView.moreInfoTabelView.delegate = self
    }
    
    func addTarget() {
        hotelView.nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
    }
    
    @objc func goToNextScreen() {
        guard let hotelName = hotelView.nameLabel.text else { return }
        navigationController?.pushViewController(RoomViewController(view: RoomView(), viewModel: RoomViewModel(), hotelName: hotelName), animated: true)
    }
}

extension HotelViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.hotelView.pageControl.currentPage = pageIndex
    }
}

extension HotelViewController: APIRequestDelegate {
    func onSucceedRequest() {
        DispatchQueue.main.async {
            guard let hotelInfo = self.hotelViewModel.hotelInformation else { return }
            self.hotelView.configure(hotelInfo)
        }
    }
}

extension HotelViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreInfoCell.reuseIdentifier, for: indexPath) as! MoreInfoCell
        cell.isUserInteractionEnabled = false
        cell.configure(hotelViewModel.moreInformation[indexPath.row])
        if indexPath.row == 2 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
