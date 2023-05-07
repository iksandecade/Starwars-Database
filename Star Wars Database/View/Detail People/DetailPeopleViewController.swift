//
//  DetailPeopleViewController.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit

class DetailPeopleViewController: BaseController {
    @IBOutlet weak var contentStackView: UIStackView!
    
    private let infoCharacterView   = DPInfoCharacterView()
    private let filmsView           = DPFilmView()
    private let speciesView         = DPSpeciesView()
    private let starshipView        = DPStarshipView()
    private let vehicleView         = DPVehicleView()
    
    private let viewModel = StarwarsViewModel()
    
    convenience init(peopleDataModel: ResponsePeopleDataModel) {
        self.init()
        viewModel.peopleData = peopleDataModel
        viewModel.filterData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupData()
    }
    
    private func setupView() {
        contentStackView.addArrangedSubview(infoCharacterView)
        contentStackView.addArrangedSubview(filmsView)
        filmsView.delegate = self
        contentStackView.addArrangedSubview(speciesView)
        speciesView.delegate = self
        contentStackView.addArrangedSubview(starshipView)
        starshipView.delegate = self
        contentStackView.addArrangedSubview(vehicleView)
        vehicleView.delegate = self
    }
    
    private func setupData() {
        guard let peopleData = viewModel.peopleData else { return }
        
        infoCharacterView.setupData(peopleData: peopleData)
        filmsView.setupData(filmsData: viewModel.filmsData)
        speciesView.setupData(speciesData: viewModel.speciesData)
        starshipView.setupData(starshipsData: viewModel.starshipsData)
        vehicleView.setupData(vehiclesData: viewModel.vehiclesData)
    }
}

extension DetailPeopleViewController: DPComponentDelegate {
    func showAlertMessage(message: String?) {
        showAlert(title: "Failed to fetch api", message: message)
    }
}
