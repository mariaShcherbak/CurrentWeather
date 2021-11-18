//
//  SecondViewController.swift
//  Weather
//
//  Created by Tanya on 11.11.2021.
//

import Foundation
import UIKit
class SecondViewController: UIViewController, SecondViewProtocol {
    
    
    @IBOutlet weak var cityCountryName: UILabel!
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var tempNow: UILabel!
    @IBOutlet weak var tempMinMax: UILabel!
    @IBOutlet weak var tempFeelsLike: UILabel!
    @IBOutlet weak var windSpeed : UILabel!
    @IBOutlet weak var spiner: UIActivityIndicatorView! // добавить в протокол (не получилось)
    //
    var presenter: SecondPresenterProtocol!
    var cityCountry: String?
    var spinerIsOn: Bool?
    var weatherForScreen: Weather?
    
    override func viewDidLoad() {
        presenter = SecondPresenter(view: self, networkServise: NetworkService())
        cityCountryName.text = cityCountry
        
        //заполнение даты на экране
        dateToday()
        
        
        spiner.startAnimating()
        spiner.hidesWhenStopped = true
        // spiner.stopAnimating()
        if spiner.isAnimating {
            spinerIsOn = true
        }
        
       // загрузить погоду
        presenter.loadWeather()
        
        
       
       
    }
    
    func dateToday() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        today.text = result
    }
    
    
    func updateUIWithWeather(weather: Weather) {
        print("updateUIWithWeather")
        tempNow.text = String(weather.main?.temp ?? 0.0)
        tempMinMax.text = String(weather.main?.tempMin ?? 0.0) + " / " + String(weather.main?.tempMin ?? 0.0)
        tempFeelsLike.text = String(weather.main?.feelsLike ?? 0.0)
        windSpeed.text = String(weather.wind?.speed ?? 0.0)
        
            // заполнить тексты
        
    }
    
    
    
    
}
