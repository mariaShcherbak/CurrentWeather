//
//  CityModel.swift
//  Weather
//
//  Created by Tanya on 01.11.2021.
//

import Foundation
struct City: Codable {
    let name: String?
    let country: String?
    var isSelected: Bool?
}

struct CityForSections {
    let nameSection: String
    var cityListArray: [City]
}

