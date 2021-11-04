//
//  MainViewController.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate {
    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet weak var CityTableView: UITableView!
    @IBOutlet weak var nameCitySearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self, networkServise: NetworkService())
        //presenter.searchWithText("Kharkiv")
        self.nameCitySearch.delegate = self
    }
    func textFieldShouldReturn(textField: UISearchBar) -> Bool {
        textField.resignFirstResponder()
        presenter.searchWithText(textField.text!)
            return true
       
        
        }
    }
    



extension MainViewController: MainViewProtocol {
    
    func updateWithWeather(_ weather: Weather) {
        
    }
}



extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.city?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let city = presenter.city?[indexPath.row]
        cell.textLabel?.text = "Test"
        return cell
    }
}
