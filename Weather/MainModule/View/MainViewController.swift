//
//  MainViewController.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, MainViewProtocol, CellProtocol {
    let defaultsSelectedCities = UserDefaults.standard
    var selectedСities: [City] = [
        City(name: "bestCity", country: "bestCounty", isSelected: true)
    ] // избранные города
    
    var like: Bool = false
    var presenter: MainViewPresenterProtocol!
    var cityArray: [City] = []
    var arrayCityForSections = [CityForSections]()
    var textSearch : String?
    var searchCityForWeather: String?
    @IBOutlet weak var CityTableView: UITableView!
    @IBOutlet weak var nameCitySearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CityTableView.register(UINib(nibName: "ViewCell", bundle: nil), forCellReuseIdentifier: "ViewCell")
        presenter = MainPresenter(view: self, networkServise: NetworkService())
        CityTableView.dataSource = self
        CityTableView.delegate = self
        self.nameCitySearch.delegate = self
        cityArray = presenter.showCities().sorted{ $0.name ?? "" < $1.name ?? "" }
        if let data = UserDefaults.standard.value(forKey:"selectedСities") as? Data {
            selectedСities = try! PropertyListDecoder().decode(Array<City>.self, from: data)
       
       
        
        arrayCityForSections = [
            CityForSections(nameSection: "Section1", cityListArray: selectedСities),
            CityForSections(nameSection: "Section2", cityListArray: cityArray)
        ]
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textSearch = searchBar.text
        cityArray = presenter.searchWithText(textSearch!)
        print(cityArray )
        CityTableView.reloadData()
        }
}
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in: UITableView) -> Int {
        return arrayCityForSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCityForSections[section].cityListArray.count
    }
    
    // заполнение cell массивом
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = CityTableView.dequeueReusableCell(withIdentifier: "ViewCell", for: indexPath) as? TableViewCell {
        var model = arrayCityForSections[indexPath.section].cityListArray[indexPath.row]
        cell.labelCell.text = model.name! + "," + model.country!
        
        cell.callback = {
            let index = indexPath.row
            print("button pressed", index)
            model.isSelected = !(model.isSelected ?? false)
            self.arrayCityForSections[indexPath.section].cityListArray[indexPath.row] = model
            if model.isSelected! {
                self.selectedСities.append(model)
                print(self.selectedСities)
                
                UserDefaults.standard.set(try? PropertyListEncoder().encode(self.selectedСities), forKey:"selectedСities")
                
               
            }
                
                self.CityTableView.reloadData()
        }
            
        let cellForSelected = self.CityTableView.dequeueReusableCell(withIdentifier: "ViewCell", for: indexPath) as! TableViewCell
        print(cellForSelected)
        cell.conditionButton = model.isSelected ?? false
        cell.updateButtonState()
        searchCityForWeather = cell.labelCell.text
        
        return cell
        }
        return UITableViewCell()
        
    }
    //переход на новое вью по клику на ячейку, отображение в лейбле выбранного города
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
              let newVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
       navigationController?.pushViewController(newVC!, animated: true)
        
        newVC?.cityCountry = searchCityForWeather ?? ""
        print(newVC?.cityCountry ?? "")
        
        
        
    }
    

    
    }




