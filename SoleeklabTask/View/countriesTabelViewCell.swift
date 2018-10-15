//
//  countriesTabelViewCell.swift
//  SoleeklabTask
//
//  Created by MacBook Pro on 10/15/18.
//  Copyright © 2018 Bassyouni. All rights reserved.
//

import UIKit

class countriesTabelViewCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    
    func configureCell(country: Country)
    {
        countryNameLabel.text = country.name
    }

}
