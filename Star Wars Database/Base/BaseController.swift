//
//  BaseController.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit
import SnapKit

let connectionNotif = Notification.Name("com.starwars.notification")

class BaseController: UIViewController {
    @IBOutlet var container: UIStackView?
    @IBOutlet var scrollView: UIScrollView?
    
    lazy internal var containerView = UIView()
    
    @IBInspectable var containerBackground: UIColor? {
        didSet {
            container?.backgroundColor = containerBackground
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let container {
            view.backgroundColor = containerBackground ?? .white
            
            view.addSubview(containerView)
            containerView.snp.makeConstraints { make in
                make.leading.trailing.equalTo(view)
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalToSuperview()
            }
            
            container.removeFromSuperview()
            containerView.addSubview(container)
            container.snp.makeConstraints { make in
                make.leading.trailing.top.bottom.equalToSuperview()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineConnection(_:)), name: connectionNotif, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: connectionNotif, object: nil)
    }
    
    //MARK: Helper
    @objc func showOfflineConnection(_ notification: Notification) {
        showAlert(title: "Connection Lost", message: "No internet connection, check again")
    }
    
    func showAlert(title: String? = nil, message: String? = nil, onDismiss completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            completion?()
        }))
        self.present(alert, animated: true)
    }
}
