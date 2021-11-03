//
//  MainPresenter.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation

protocol MainViewProtocol: class {
    func updateWithWeather(_ weather: Weather)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkServise: NetworkServiceProtocol)
    var currentWeather: [CurrentWeather]? {get set}
    
    func searchWithText(_ text: String)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkServise: NetworkServiceProtocol!
    var currentWeather: [CurrentWeather]?
   
    //var nameCitySearchText =
    

   
    required init(view: MainViewProtocol, networkServise: NetworkServiceProtocol) {
        self.view = view
        self.networkServise = networkServise
    }
    
    func searchWithText(_ text: String) {
        
    }
   //п http://htmlweb.ru/geo/api.php?json&city_name=Харьков&api_key=38db0239405b5a7dcea6c9890f99ccb9
}

//extension MainPresenter: MainViewPresenterProtocol {
//
//
//}
