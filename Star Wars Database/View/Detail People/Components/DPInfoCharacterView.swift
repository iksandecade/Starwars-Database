//
//  DPHeaderView.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 07/05/23.
//

import UIKit

class DPInfoCharacterView: BaseView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var massLabel: UILabel!
    @IBOutlet private weak var hairColorLabel: UILabel!
    @IBOutlet private weak var skinColorLabel: UILabel!
    @IBOutlet private weak var eyeColorLabel: UILabel!
    @IBOutlet private weak var birthYearLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    
    func setupData(peopleData: ResponsePeopleDataModel) {
        nameLabel.text = peopleData.name
        heightLabel.text = peopleData.height
        massLabel.text = peopleData.mass
        hairColorLabel.text = peopleData.hair_color
        skinColorLabel.text = peopleData.skin_color
        eyeColorLabel.text = peopleData.eye_color
        birthYearLabel.text = peopleData.birth_year
        genderLabel.text = peopleData.gender
    }
}
