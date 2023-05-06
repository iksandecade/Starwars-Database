//
//  StarwarsTableView.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit

enum DataViewState {
    case Empty
    case EmptySearch
    case Error
    case Loading
    case Populated
    case Offline
}

class StarwarsTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.superview?.layoutIfNeeded()
        }
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        var height = contentSize.height
        if state == .Empty || state == .Error || state == .Offline { height = 600 }
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
        case .Offline:
            setIsOffline(true)
        default: return
        }
    }
}
