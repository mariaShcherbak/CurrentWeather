//
//  ApiManager.swift
//  Weather
//
//  Created by Tanya on 26.10.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData() -> Data?
    func getAllCity() -> [City]?
}


class NetworkService: NetworkServiceProtocol {

    var dataAllCity = Data()
   
    func getData() -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: "city.list", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                dataAllCity = try Data(contentsOf: fileUrl)
                return dataAllCity
            }
        } catch {
            print("error: \(error)")
        }
        return nil
        
    }
   
    func getAllCity() -> [City]? {
        do {
            let decodedData = try JSONDecoder().decode([City].self, from: dataAllCity)
            return decodedData
        } catch {
            print("getAllCity error: \(error)")
        }
        return nil
    }
    
    
    
    }


    
    
/*  func getCity(string: String, completition: @escaping([City]) -> Void) {
     // var searchText = "харьков"
      var url = "http://htmlweb.ru/geo/api.php?city_name=" + searchText + "&json&api_key=38db0239405b5a7dcea6c9890f99ccb9"
      print(url)
      /////http://htmlweb.ru/geo/api.php?city_name=Kharkov&json&api_key=38db0239405b5a7dcea6c9890f99ccb9
      var request = URLRequest(url: URL(string: url)!)
      var task = URLSession.shared.dataTask(with: request) {
          data, response, error in
          if let data = data, let city = try? JSONDecoder().decode([City].self, from: data) {
              completition(city)
              print(completition(city))
              self.cityArray = city
            //  print(self.cityArray)
            //  cityArray?.append([City])
          }
          else {
              
          }
      }
      task.resume()
      */
