//
//  SecondViewController.swift
//  Weather
//
//  Created by Tanya on 11.11.2021.
//

import Foundation
import UIKit
class SecondViewController: UIViewController, SecondViewProtocol {
    var presenter: SecondPresenterProtocol!
    var cityCountry: String?
    var spinerIsOn: Bool?
    @IBOutlet weak var cityCountryName: UILabel!
 
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        presenter = SecondPresenter(view: self, networkServise: NetworkService())
        cityCountryName.text = cityCountry
        spiner.startAnimating()
        if spiner.isAnimating {
            spinerIsOn = true
            print(spinerIsOn)
        }
       presenter.loadWeather()
    }
    
    
}
