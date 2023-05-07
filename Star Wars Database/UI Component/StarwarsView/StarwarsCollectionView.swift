//
//  StarwarsCollectionView.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit

class StarwarsCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.superview?.layoutIfNeeded()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        var height = contentSize.height
        if state == .Empty || state == .Error || state == .Offline { height = 100 }
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    var state: DataViewState = .Loading {
        didSet { updateView() }
    }
    
    func setState(_ state: DataViewState) {
        self.state = state
    }
    
    private func updateView() {
        clearStateViews()
        switch state {
        case .Empty:
            setIsEmpty(true)
        case .Error:
            setIsError(true)
        default: reloadData()
        }
    }
}
