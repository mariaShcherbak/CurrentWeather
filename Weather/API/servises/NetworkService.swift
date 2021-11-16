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
    func getWeather(string: String, completition: @escaping(Weather) -> Void)
    var receivedWeather : Weather? { get set }
}


class NetworkService: NetworkServiceProtocol {
    var receivedWeather : Weather?
   
    func getData() -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: "city.list", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
               let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
        
    }
   
    func getAllCity() -> [City]? {  //поменять на getData
        do {
            let decodedData = try JSONDecoder().decode([City].self, from: getData()!)
            return decodedData
        } catch {
            print("getAllCity error: \(error)")
        }
        return nil
    }
    
    // второй запрос
    func getWeather(string: String, completition: @escaping(Weather) -> Void) {
          let url = "https://api.openweathermap.org/data/2.5/weather?q=" + string + "&appid=a0c15454e4511c5f6f347ad2fd72b355"
          let request = URLRequest(url: URL(string: url)!)
          let task = URLSession.shared.dataTask(with: request) {
              data, response, error in
              if let data = data, let weather = try? JSONDecoder().decode(Weather.self, from: data)
              {
                completition(weather)
                print("let weather")
                //self.receivedWeather = weather
              //  print(self.receivedWeather ?? "")
            
              }
              else {
              }
          }
          task.resume()
        
        print("task.resume()")
    }


    
}
