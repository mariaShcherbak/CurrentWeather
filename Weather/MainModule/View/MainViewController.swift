//
//  MainViewController.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate{
    var presenter: MainViewPresenterProtocol!
    var cityArray: [City]?
    @IBOutlet weak var CityTableView: UITableView!
    @IBOutlet weak var nameCitySearch: UISearchBar!
    var textSearch : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self, networkServise: NetworkService())
        CityTableView.dataSource = self
        CityTableView.delegate = self
        self.nameCitySearch.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textSearch = searchBar.text
        cityArray = presenter.searchWithText(textSearch!)
        print(cityArray ?? "the city is not in the list")
        CityTableView.reloadData()
        }
}

extension MainViewController: MainViewProtocol {
    
    func updateWithWeather(_ weather: Weather) {
        
    }
}



extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CityTableView.dequeueReusableCell(withIdentifier: "сityCell") as! CityTableViewCell
        let model = cityArray?[indexPath.row]
        cell.labelCell.text = model!.name! + ", " + model!.country!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        let newVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
       navigationController?.pushViewController(newVC!, animated: true)
        
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



