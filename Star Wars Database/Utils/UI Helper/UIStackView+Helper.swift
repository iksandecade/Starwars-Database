//
//  UIStackView+Helper.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation
import SnapKit

extension UIStackView {
    func addArrangedSubviewAtLast(_ view: UIView) {
        insertArrangedSubview(view, at: arrangedSubviews.count)
    }
    
    func addArranggedSubviewAtFirst(_ view: UIView) {
        insertArrangedSubview(view, at: 0)
    }
    
    func removeArrangedSubviews() {
        arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func removeArrangedSubview(_ view: UIView) {
        arrangedSubviews.forEach({ if $0 == view { $0.removeFromSuperview() }})
    }
    
    func addSpacer(height: Int = 0, color: UIColor = .clear) {
        let separator = UIView()
        separator.backgroundColor = color
        if height != 0 {
            separator.snp.makeConstraints { make in
                make.height.equalTo(height)
            }
        }
        addArrangedSubview(separator)
    }
}
