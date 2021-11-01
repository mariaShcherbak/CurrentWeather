//
//  MainViewController.swift
//  Weather
//
//  Created by Tanya on 28.10.2021.
//

import Foundation
import UIKit

class MainViewController: UIViewController, MainViewProtocol {
    var presenter: MainViewProtocol!
    
    @IBOutlet weak var CityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var nameCitySearch: UISearchBar!
}



