//
//  MainViewController.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, MainViewProtocol, CellProtocol {
    var like: Bool = false
    var presenter: MainViewPresenterProtocol!
    var cityArray: [City] = []
    var selectedСities: [City] = [
        City(name: "bestCity", country: "bestCounty", isSelected: false)
    ] // избранные города
    var arrayCityForSections = [CityForSections]()
    var textSearch : String?
    var searchCityForWeather: String?
    @IBOutlet weak var CityTableView: UITableView!
    @IBOutlet weak var nameCitySearch: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self, networkServise: NetworkService())
        CityTableView.dataSource = self
        CityTableView.delegate = self
        self.nameCitySearch.delegate = self
        cityArray = presenter.showCities().sorted{ $0.name ?? "" < $1.name ?? "" }
        arrayCityForSections = [
            CityForSections(nameSection: "Section1", cityListArray: selectedСities),
            CityForSections(nameSection: "Section2", cityListArray: cityArray)
        ]
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
        return arrayCityForSections.count
    }
        
    //количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCityForSections[section].cityListArray.count
    }
    
    // заполнение cell массивом
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CityTableView.dequeueReusableCell(withIdentifier: "сityCell") as! CityTableViewCell
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
                self.CityTableView.reloadData()
            }
            
        }
        let cellForSelected = self.CityTableView.dequeueReusableCell(withIdentifier: "сityCell", for: indexPath) as! CityTableViewCell
        print(cellForSelected)
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
        print(newVC?.cityCountry)
        
        
        
    }
    

    
    
    
    }

protocol CellProtocol {
    var selectedСities: [City] {get set}
}

class CityTableViewCell: UITableViewCell, CellProtocol {
    var selectedСities: [City] = []
    var conditionButton = false
    
    
    static let idCell = "сityCell"
    
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var buttonInCell: UIButton!
    var callback: (()->Void)?
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(true, animated: true)
        
    }
    func callback(indexPath: IndexPath) {}
    
   @IBAction func likeButtonPressed(_ sender: UIButton) {
        callback?()
        conditionButton = !conditionButton
        updateButtonState()
    }
    
  
    func updateButtonState() {
        if conditionButton {
            buttonInCell.setImage(UIImage(named: "on"), for: .normal)
        //  добавить удаление из избранного
        }
        else {
            buttonInCell.setImage(UIImage(named: "true"), for: .normal)
            
            //print(selectedСities)
        }
    }
}



