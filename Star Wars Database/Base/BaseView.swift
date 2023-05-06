//
//  BaseView.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit
import SnapKit

class Baseview: UIView {
    @IBOutlet var view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self)
        
        addContent(view)
    }
    
    func addContent(_ content: UIView?) {
        guard let content else { return }
        
        addSubview(content)
        content.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
    }
}
