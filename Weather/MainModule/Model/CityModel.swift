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
    
}

struct CityForSections {
    let nameSection: String
    let cityListArray: [City]
}

