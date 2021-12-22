//
//  MainViewController.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation
import UIKit


class MainViewController: UIViewController, UISearchBarDelegate, MainViewProtocol, CellProtocol {

    enum Section {
        case favorites
        case all

        var name: String {
            switch self {
            case .favorites:
                return "Section 1"
            case .all:
                return "Section 2"
            }
        }
    }

    let defaultsSelectedCities = UserDefaults.standard
    var selectedСities: [City] = []
    var cityArray: [City] = []
    
    var like: Bool = false
    var presenter: MainViewPresenterProtocol!
    var textSearch : String?
    var searchCityForWeather: String?
    @IBOutlet weak var CityTableView: UITableView!
    @IBOutlet weak var nameCitySearch: UISearchBar!

    var sections: [Section] {
        if !selectedСities.isEmpty {
            return [.favorites, .all]
        } else {
            return [.all]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.CityTableView.register(UINib(nibName: "ViewCell", bundle: nil), forCellReuseIdentifier: "ViewCell")
        presenter = MainPresenter(view: self, networkServise: NetworkService())
        CityTableView.dataSource = self
        CityTableView.delegate = self
        self.nameCitySearch.delegate = self
        let allCities = presenter.showCities()
        if let data = UserDefaults.standard.value(forKey:"selectedСities") as? Data {
            selectedСities = try! PropertyListDecoder().decode(Array<City>.self, from: data)
        }
        setAllCitiesWithoutSelected(allCities: allCities, selected: selectedСities)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textSearch = searchBar.text
        cityArray = presenter.searchWithText(textSearch!)
        print(cityArray )
        CityTableView.reloadData()
    }

    private func modelAtIndex(_ index: Int, atSection section: Int) -> City {
        let section = sections[section]
        switch section {
        case .favorites:
            return selectedСities[index]
        case .all:
            return cityArray[index]
        }
    }

    private func moveCityToAppropriateArray(_ city: City) {
        let isSelected = city.isSelected ?? false
        if isSelected {
            if let index = cityArray.firstIndex(of: city), selectedСities.firstIndex(of: city) == nil {
                cityArray.remove(at: index)
                selectedСities.append(city)
                selectedСities.sort { $0.name ?? "" < $1.name ?? "" }
            }
        } else {
            if let index = selectedСities.firstIndex(of: city), cityArray.firstIndex(of: city) == nil {
                selectedСities.remove(at: index)
                cityArray.append(city)
                cityArray.sort { $0.name ?? "" < $1.name ?? "" }
            }
        }
    }

    private func setAllCitiesWithoutSelected(allCities: [City], selected: [City]) {
        var cities = allCities
        for city in selected {
            if let index = allCities.firstIndex(of: city) {
                cities.remove(at: index)
            }
        }
        cityArray = cities.sorted{ $0.name ?? "" < $1.name ?? "" }
    }

    private func saveChanges() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.selectedСities), forKey:"selectedСities")
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .favorites:
            return selectedСities.count
        case .all:
            return cityArray.count
        }
    }
    
    // заполнение cell массивом
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CityTableView.dequeueReusableCell(withIdentifier: "ViewCell", for: indexPath) as! TableViewCell
        var model = modelAtIndex(indexPath.row, atSection: indexPath.section)

        cell.labelCell.text = model.name! + "," + model.country!
        cell.callback = {
            model.isSelected = !(model.isSelected ?? false)
            self.moveCityToAppropriateArray(model)
            self.saveChanges()
            self.CityTableView.reloadData()
        }
        cell.conditionButton = model.isSelected ?? false
        cell.updateButtonState()
        searchCityForWeather = cell.labelCell.text
        return cell
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

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].name
    }

}
