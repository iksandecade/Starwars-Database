//
//  MItemTableViewCell.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit
import SkeletonView

class MainItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func showSkeleton(isShow: Bool) {
        if isShow {
            nameLabel.showAnimatedGradientSkeleton()
        } else {
            nameLabel.hideSkeleton()
        }
    }
    
    func setupData(peopleDataModel: ResponsePeopleDataModel?) {
        showSkeleton(isShow: false)
        guard let peopleDataModel else { return }
        
        nameLabel.text = peopleDataModel.name
    }
}
