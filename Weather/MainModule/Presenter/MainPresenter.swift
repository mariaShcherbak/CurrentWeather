//
//  MainPresenter.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation

protocol MainViewProtocol: class {
    var textSearch : String? { get set }
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkServise: NetworkServiceProtocol)
    
    func searchWithText(_ text: String) -> [City]
    func showCities() -> [City]
}





class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkServise: NetworkServiceProtocol!
    

    required init(view: MainViewProtocol, networkServise: NetworkServiceProtocol) {
        self.view = view
        self.networkServise = networkServise
    }
    
    func searchWithText(_ text: String) -> [City] {
        let filterCityList = networkServise.getAllCity()?.filter({($0.name!.contains(text))})
        return filterCityList ?? [City]()
           
        
        }
    func showCities() -> [City] {
        return networkServise.getAllCity() ?? []
    }
}
