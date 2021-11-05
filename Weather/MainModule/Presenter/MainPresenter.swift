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
    
    var city: [City]? {get set}
    
    func searchWithText(_ text: String)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkServise: NetworkServiceProtocol!
    var city: [City]?

    required init(view: MainViewProtocol, networkServise: NetworkServiceProtocol) {
        self.view = view
        self.networkServise = networkServise
    }
    
    func searchWithText(_ text: String) {
        networkServise.getCity(string: text, completition: { ([City]) in
            guard self != nil else { return }
        })
    
    
        }
}
