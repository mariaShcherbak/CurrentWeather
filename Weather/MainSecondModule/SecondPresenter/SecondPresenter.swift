//
//  SecondPresenter.swift
//  Weather
//
//  Created by Tanya on 09.11.2021.
//

import Foundation
protocol SecondViewProtocol: class {
    
    var cityCountry : String? { get set } // label
    var spinerIsOn: Bool? { get set }
}

protocol SecondPresenterProtocol: class {
    init(view: SecondViewProtocol, networkServise: NetworkServiceProtocol)
    func loadWeather()
    
}


class SecondPresenter: SecondPresenterProtocol {
    weak var view: SecondViewProtocol?
    let networkServise: NetworkServiceProtocol!
    

    required init(view: SecondViewProtocol, networkServise: NetworkServiceProtocol) {
        self.view = view
        self.networkServise = networkServise
    }
    
    func loadWeather() {
        if view?.spinerIsOn == true {
            networkServise.getWeather(string: view?.cityCountry ?? "") { (Weather) in
                guard self != nil else {return}
            }
        }
    }
   
         
        
    
}
