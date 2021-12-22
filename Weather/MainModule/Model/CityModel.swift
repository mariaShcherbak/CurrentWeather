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

extension City: Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name && lhs.country == rhs.country
    }
}

