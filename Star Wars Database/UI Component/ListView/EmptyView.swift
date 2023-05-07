//
//  EmptyView.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 07/05/23.
//

import UIKit

class EmptyView: UIView {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var actionButton: UIButton?
 
    func configure(title: String?, subtitle: String?, actionTitle: String?, action: (() -> Void)?) {
            titleLabel?.isHidden = title == nil
            titleLabel?.text = title
            subtitleLabel?.isHidden = subtitle == nil
            subtitleLabel?.text = subtitle
            actionButton?.isHidden = actionTitle == nil
            actionButton?.setTitle(actionTitle, for: .normal)
            if let action = action { actionButton?.addTapHandler(action) }
        }

}
