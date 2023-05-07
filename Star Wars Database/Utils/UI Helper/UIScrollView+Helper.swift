//
//  UIScrollView+Helper.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit

private var emptyKey: UInt8 = 0
private var errorKey: UInt8 = 0
private var offlineKey: UInt8 = 0
private var loadingKey: UInt8 = 0

protocol StateConfigurable {
    func setState(state: DataViewState)
    func setEmptyView(title: String?, subtitle: String?, actionTitle: String?, action: (() -> Void)?)
    func setErrorView(reloadAction action: (() -> Void)?)
}

extension UIScrollView {
    var emptyView: UIView? {
        get { return associatedObject(base: self, key: &emptyKey) }
        set { associateObject(base: self, key: &emptyKey, value: newValue) }
    }
    var errorView: UIView? {
        get { return associatedObject(base: self, key: &errorKey) }
        set { associateObject(base: self, key: &errorKey, value: newValue) }
    }
    var offlineView: UIView? {
        get { return associatedObject(base: self, key: &offlineKey) }
        set { associateObject(base: self, key: &offlineKey, value: newValue) }
    }
    
    func setEmptyView(title: String?, subtitle: String?, actionTitle: String? = nil, action: (() -> Void)? = nil) {
        let ev = UIView.nib(withType: EmptyView.self)
        ev.configure(title: title, subtitle: subtitle, actionTitle: actionTitle, action: action)
        self.emptyView = ev
    }
    func setErrorView(reloadAction action: (() -> Void)?) {
        let ev = UIView.nib(withType: ListErrorView.self)
        ev.configure(reloadAction: action)
        self.errorView = ev
    }
    
    func setOfflineView(reloadAction action: (() -> Void)?) {
        let ev = UIView.nib(withType: ListErrorView.self)
        ev.configure(messages: "No internet connection, tap to try again", reloadAction: action)
        self.offlineView = ev
    }
    
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    
    func setIsEmpty(_ isEmpty: Bool) {
        if isEmpty {
            guard let emptyView = emptyView else { return }
            emptyView.tag = 5000
            self.superview?.addSubview(emptyView)
            emptyView.snp.makeConstraints({ (make) in
                make.leading.trailing.top.bottom.equalTo(self)
            })
        } else {
            guard let subviews = self.superview?.subviews else { return }
            for s in subviews {
                if s.tag == 5000 {
                    s.removeFromSuperview()
                }
            }
        }
    }
    
    func setIsOffline(_ isOffline: Bool) {
        if isOffline {
            guard let offlineView = offlineView else { return }
            offlineView.tag = 5001
            self.superview?.addSubview(offlineView)
            offlineView.snp.makeConstraints { (make) in
                make.leading.trailing.top.bottom.equalTo(self)
            }
        } else {
            guard let subviews = self.superview?.subviews else { return }
            for s in subviews {
                if s.tag == 5001 {
                    s.removeFromSuperview()
                }
            }
        }
    }
    
    func setIsError(_ isError: Bool) {
        if isError {
            guard let errorView = errorView else { return }
            errorView.tag = 5001
            self.superview?.addSubview(errorView)
            errorView.snp.makeConstraints({ (make) in
                make.leading.trailing.top.bottom.equalTo(self)
            })
        } else {
            guard let subviews = self.superview?.subviews else { return }
            for s in subviews {
                if s.tag == 5001 {
                    s.removeFromSuperview()
                }
            }
        }
    }
    
    func clearStateViews() {
        guard let subviews = self.superview?.subviews else { return }
        for s in subviews {
            if s.tag == 5000 || s.tag == 5001 {
                s.removeFromSuperview()
            }
        }
    }
    
    func scrollToBottom(animated: Bool) {
       if self.contentSize.height < self.bounds.size.height { return }
       let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
       self.setContentOffset(bottomOffset, animated: animated)
    }
}

func associatedObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>) -> ValueType? {
    return objc_getAssociatedObject(base, key) as? ValueType
}

func associateObject<ValueType: AnyObject>(base: AnyObject,
                                           key: UnsafePointer<UInt8>,
                                           value: ValueType?) {
    objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
}
