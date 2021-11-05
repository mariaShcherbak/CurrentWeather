//
//  ApiManager.swift
//  Weather
//
//  Created by Tanya on 26.10.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCity(string: String, completition: @escaping([City]) -> Void)
}


class NetworkService: NetworkServiceProtocol {
    //var cityArray: [City]?
    func getCity(string: String, completition: @escaping([City]) -> Void) {
        var searchText = "Kharkov"
        var url = "http://htmlweb.ru/geo/api.php?json&city_name=" + searchText + "&38db0239405b5a7dcea6c9890f99ccb9"
        var request = URLRequest(url: URL(string: url)!)
        var task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data, let city = try? JSONDecoder().decode(City.self, from: data) {
                print("атппапталп")
                completition([city])
                print(completition([city]))
              //  cityArray?.append([City])
            }
        }
        task.resume()
        
        
        
        
        //http://htmlweb.ru/geo/api.php?json&city_name=НАЧАЛО_НАЗВАНИЯ_ГОРОДА&api_key=API_KEY_из_профиля
        
        //API_key: 38db0239405b5a7dcea6c9890f99ccb9
    }
    
}
