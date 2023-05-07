//
//  ListErrorView.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 07/05/23.
//

import UIKit

class ListErrorView: UIView {
    @IBOutlet private weak var titlaLabel: UILabel!
    @IBOutlet private weak var iconView: UIImageView!
    
    private var isLoading: Bool = false {
        didSet {
            updateViews()
        }
    }
    var message: String = "Oops error, tap to try again"
    private var loadingAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        titlaLabel.text = message
        addTapHandler {
            self.setLoading(false)
            self.loadingAction?()
            self.setLoading(true)
        }
    }
    
    func configure(messages: String? = nil,reloadAction action: (() -> Void)?) {
        self.loadingAction = action
        if let messages = messages { titlaLabel.text = messages }
    }
    
    func setLoading(_ bool: Bool) {
        isLoading = bool
    }
    
    private func updateViews() {
        if isLoading { iconView.startRotating() }
        else { iconView.stopRotating() }
    }
    
}
