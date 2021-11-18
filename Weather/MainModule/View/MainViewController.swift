//
//  MainViewController.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, MainViewProtocol {
    var presenter: MainViewPresenterProtocol!
    var cityArray: [City]?
    var selectedСities: [City] = [] // избранные города
    @IBOutlet weak var CityTableView: UITableView!
    @IBOutlet weak var nameCitySearch: UISearchBar!
    var textSearch : String?
    var searchCityForWeather: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self, networkServise: NetworkService())
        CityTableView.dataSource = self
        CityTableView.delegate = self
        self.nameCitySearch.delegate = self
        cityArray = presenter.showCities().sorted{ $0.name ?? "" < $1.name ?? "" }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textSearch = searchBar.text
        cityArray = presenter.searchWithText(textSearch!)
        print(cityArray ?? "the city is not in the list")
        CityTableView.reloadData()
        }
}

extension MainViewController: UITableViewDataSource {
    
    //количество секций
    func numberOfSections(in: UITableView) -> Int {
        if selectedСities.isEmpty {
            return 1
        }
        return 2
    }

    
    //количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return selectedСities.count ?? 0 // вставить массив с избранным
        }
        else {
            return cityArray?.count ?? 0
        }
        
    }
    
    // заполнение cell массивом (переделать под 2 секции)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CityTableView.dequeueReusableCell(withIdentifier: "сityCell") as! CityTableViewCell
        let model = cityArray?[indexPath.row]
        cell.labelCell.text = model!.name! + "," + model!.country!
        searchCityForWeather = cell.labelCell.text
        return cell
        
    }
    //переход на новое вью по клику на ячейку, отображение в лейбле выбранного города
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
              let newVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
       navigationController?.pushViewController(newVC!, animated: true)
        
        newVC?.cityCountry = searchCityForWeather ?? ""
        print(newVC?.cityCountry)
        
    }
    
    }


class CityTableViewCell: UITableViewCell {
    static let idCell = "сityCell"
    
    @IBOutlet weak var cell: UIView!
    
    @IBOutlet weak var labelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(true, animated: true)
        
    }
}



