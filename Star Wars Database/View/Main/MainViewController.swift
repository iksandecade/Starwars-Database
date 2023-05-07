//
//  ViewController.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit

class MainViewController: BaseController {
    @IBOutlet private weak var listTableView: StarwarsTableView!
    
    private let viewModel = StarwarsViewModel()
    private var itemsProvider: PeopleListLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        subscribePeopleList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.main.async {
            self.listTableView.refreshControl?.beginRefreshing()
            self.listTableView.refreshControl?.endRefreshing()
        }
    }
    
    private func setupTableView() {
        listTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        listTableView.registerNIB(with: MainItemTableViewCell.self)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.setEmptyView(title: "No People", subtitle: nil)
        listTableView.setErrorView {
            self.loadData { success in
                self.refreshData(success: success)
            }
        }
        listTableView.setOfflineView {
            self.loadData { success in
                self.refreshData(success: success)
            }
        }
        listTableView.addRefreshControl(in: self)
    }
    
    private func subscribePeopleList() {
        itemsProvider = PeopleListLoader()
        itemsProvider?.items.subscribe(onNext: { data in
            self.viewModel.listPeopleData = data
            self.refreshData(success: true)
        }).disposed(by: disposeBag)
        
        self.loadData { success in
            self.refreshData(success: success)
        }
    }
    
    private func loadData(_ handler: ((Bool) -> Void)? = nil) {
        if NetworkManager.isOnline() {
            listTableView.setState(.Loading)
            itemsProvider?.loadInitial({ error in
                handler?(error == nil)
                if let error {
                    self.showAlert(title: nil, message: error.localizedDescription)
                }
            })
        } else {
            listTableView.setState(.Offline)
            listTableView.reloadData()
        }
    }
    
    private func refreshData(success: Bool) {
        var state: DataViewState = .Loading
        if success {
            state = viewModel.listPeopleData.isEmpty ? .Empty : .Populated
        } else {
            state = .Error
        }
        
        listTableView.setState(state)
        listTableView.reloadData()
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTableView.state == .Loading ? 10 : viewModel.listPeopleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(with: MainItemTableViewCell.self) else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        if listTableView.state == .Loading {
            cell.showSkeleton(isShow: true)
        } else {
            cell.setupData(peopleDataModel: viewModel.listPeopleData[indexPath.row])
            
            if indexPath.item == viewModel.listPeopleData.count - 2 {
                self.itemsProvider?.loadMore({ error in
                    if let error {
                        self.showAlert(title: nil, message: error.localizedDescription)
                    }
                })
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listTableView.state == .Populated {
            let vc = DetailPeopleViewController(peopleDataModel: viewModel.listPeopleData[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainViewController: Refreshable {
    @objc func refreshControlValueChanged(_ sender: UIRefreshControl) {
        if NetworkManager.isOnline() {
            self.loadData { success in
                sender.endRefreshing()
                self.refreshData(success: success)
            }
        } else {
            sender.endRefreshing()
            listTableView.setState(.Offline)
            listTableView.reloadData()
        }
    }
}
