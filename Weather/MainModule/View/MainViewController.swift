//
//  MainViewController.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet weak var CityTableView: UITableView!
    @IBOutlet weak var nameCitySearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self, networkServise: NetworkService())
        presenter.searchWithText("Kharkiv")
    }
    
    
}

extension MainViewController: MainViewProtocol {
    
    func updateWithWeather(_ weather: Weather) {
        
    }
}


