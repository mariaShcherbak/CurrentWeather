//
//  MainPresenter.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation

protocol MainViewProtocol: class {
    func updateWithWeather(_ weather: Weather)
    var textSearch : String? { get set }
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkServise: NetworkServiceProtocol)
    
    func searchWithText(_ text: String) -> [City]
}





class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkServise: NetworkServiceProtocol!
    

    required init(view: MainViewProtocol, networkServise: NetworkServiceProtocol) {
        self.view = view
        self.networkServise = networkServise
    }
    
    func searchWithText(_ text: String) -> [City] {
        networkServise.getData()
        let filterCityList = networkServise.getAllCity()?.filter({($0.name!.contains(text))})
       
        /*networkServise.getWeather(string: text) { (Weather) in
            guard self != nil else {return}
        } */
        return filterCityList ?? [City]()
           
        
        }
}
