//
//  DPVehicleView.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit

class DPVehicleView: BaseView {
    @IBOutlet weak var listCollectionView: StarwarsCollectionView!
    
    @IBOutlet weak var noDataLabel: UILabel!
    private let viewModel = StarwarsViewModel()
    
    var delegate: DPComponentDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupCollectionView()
    }
    
    func setupData(vehiclesData: [VehicleDataModel]) {
        viewModel.vehiclesData = vehiclesData
        listCollectionView.reloadData()
        
        noDataLabel.isHidden = !viewModel.vehiclesData.isEmpty
        listCollectionView.isHidden = viewModel.vehiclesData.isEmpty
    }
    
    private func setupCollectionView() {
        listCollectionView.registerNIB(with: DPItemCollectionViewCell.self)
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
}

extension DPVehicleView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.vehiclesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(with: DPItemCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell() }
        
        if let data = viewModel.vehiclesData[indexPath.row].data {
            cell.setupData(title: data.name)
        } else {
            cell.showSkeleton(isShow: true)
            viewModel.getDetailVehicle(id: viewModel.vehiclesData[indexPath.row].id) { isSuccess, error in
                if isSuccess {
                    if let data = self.viewModel.vehiclesData[indexPath.row].data {
                        cell.setupData(title: data.name)
                    }
                    collectionView.reloadItems(at: [indexPath])
                } else {
                    self.delegate?.showAlertMessage(message: error?.localizedDescription)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueCell(with: DPItemCollectionViewCell.self, for: indexPath) else { return CGSize.zero }
        if let data = viewModel.vehiclesData[indexPath.row].data {
            cell.setupData(title: data.name)
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            return CGSize(width: size.width, height: 48)
        } else {
            return CGSize(width: 120, height: 48)
        }
    }
}
