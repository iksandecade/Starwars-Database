//
//  ListErrorView.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit

class ListErrorView: BaseView {
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var iconImageView: UIImageView?
    
    var message = "Oops error, tap to try again"
    
    private var loadingAction: (() -> Void)?
    private var isLoading: Bool = false {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        titleLabel?.text = message
        addTapHandler {
            self.setLoading(false)
            self.loadingAction?()
            self.setLoading(true)
        }
    }
    
    func configure(messages: String? = nil, reloadAction action: (() -> Void)?) {
        self.loadingAction = action
        if let messages = messages { titleLabel?.text = messages }
    }
    
    func setLoading(_ bool: Bool) {
        isLoading = bool
    }
    
    private func updateViews() {
        isLoading ? iconImageView?.startAnimating() : iconImageView?.stopAnimating()
    }
}
