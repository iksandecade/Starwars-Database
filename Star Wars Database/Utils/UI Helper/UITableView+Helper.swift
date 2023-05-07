//
//  UITableView+Helper.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit

extension UITableView {
    override open var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func register(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
    }
    
    func registerHeaderFooterView(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forHeaderFooterViewReuseIdentifier: className)
    }
    
    func dequeueHeaderFooterView<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: cellClass)) as? T
    }
    
    func setFooterSpaceHeight(_ height: CGFloat) {
        self.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: height))
    }
    
    func hideEmptyCells() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func setEmptyMessage(_ message: String) {
        let width: CGFloat = UIScreen.main.bounds.size.width
        let height: CGFloat = self.bounds.size.height
        let messageLabel = UILabel()
        messageLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
        messageLabel.center = self.center
        messageLabel.textColor = .lightGray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

extension UITableView {
    func addRefreshControl(in vc: UIViewController, title: String = "Loading...", tintColor: UIColor = .black) {
        self.refreshControl = nil
        let refreshControl: UIRefreshControl = UIRefreshControl(frame: .zero)
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.tintColor = tintColor
        refreshControl.addTarget(vc, action: #selector(refreshControlValueChanged(_:)), for: .valueChanged)
        
        self.refreshControl = refreshControl
    }
    
    func removeRefreshControl() {
        self.refreshControl = nil
    }
    
    @objc func refreshControlValueChanged(_ sender: UIRefreshControl) {}
}

extension UITableView {
    func reloadAllSections() {
        let sections = self.numberOfSections
        self.reloadSections(IndexSet(integersIn: 0..<sections), with: .automatic)
    }
}

extension UITableView {
    func scrollToBottom(isAnimated:Bool = true){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }
    
    func scrollToTop(isAnimated:Bool = true) {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: isAnimated)
            }
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

protocol Refreshable {
    func refreshControlValueChanged(_ sender: UIRefreshControl)
}
