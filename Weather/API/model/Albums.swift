//
//  Albums.swift
//  Weather
//
//  Created by Tanya on 26.10.2021.
//

import Foundation
// MARK: - Album
struct Album: Codable {
    let userID, id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

typealias Albums = [Album]
