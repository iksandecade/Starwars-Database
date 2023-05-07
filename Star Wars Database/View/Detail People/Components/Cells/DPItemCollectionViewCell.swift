//
//  DPItemCollectionViewCell.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit
import SkeletonView

class DPItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func showSkeleton(isShow: Bool) {
        if isShow {
            titleLabel.text = "Loading.."
            titleLabel.showAnimatedGradientSkeleton()
        } else {
            titleLabel.hideSkeleton()
        }
    }
    
    func setupData(title: String?) {
        showSkeleton(isShow: false)
        titleLabel.text = title
    }

}
