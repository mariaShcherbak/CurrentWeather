//
//  ApiManager.swift
//  Weather
//
//  Created by Tanya on 26.10.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCity()
}


class NetworkService: NetworkServiceProtocol {
    func getCity() {
       var searchText = "Khar"
        var urll = "http://htmlweb.ru/geo/api.php?json&city_name=" + searchText + "&38db0239405b5a7dcea6c9890f99ccb9"
        var request = URLRequest(url: URL(string: urll)!)
        var task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            print(String(decoding: data!, as: UTF8.self))
            print(error)
        }
        task.resume()
        
        
        
        
        //http://htmlweb.ru/geo/api.php?json&city_name=НАЧАЛО_НАЗВАНИЯ_ГОРОДА&api_key=API_KEY_из_профиля
        
        //API_key: 38db0239405b5a7dcea6c9890f99ccb9
    }
    
}
