//
//  ApiManager.swift
//  Weather
//
//  Created by Tanya on 26.10.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCity(completition: @escaping(Result<[CurrentWeather]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getCity(completition: @escaping (Result<[CurrentWeather]?, Error>) -> Void) {
        
        let urlString = "http://htmlweb.ru/geo/api.php?json&city_name=Харьков&api_key=38db0239405b5a7dcea6c9890f99ccb9"
        
        
        
        
        
        
        
        //http://htmlweb.ru/geo/api.php?json&city_name=НАЧАЛО_НАЗВАНИЯ_ГОРОДА&api_key=API_KEY_из_профиля
        
        //API_key: 38db0239405b5a7dcea6c9890f99ccb9
    }
}
