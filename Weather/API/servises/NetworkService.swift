//
//  ApiManager.swift
//  Weather
//
//  Created by Tanya on 26.10.2021.
//

import Foundation
import Alamofire

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
   
    func getAllCity() -> [City]? {
        do {
            let decodedData = try JSONDecoder().decode([City].self, from: getData()!)
            return decodedData
        } catch {
            print("getAllCity error: \(error)")
        }
        return nil
    }
    
    func getWeather(string: String, completition: @escaping(Weather) -> Void) {
        let parameters = ["q": string, "appid": "a0c15454e4511c5f6f347ad2fd72b355"]
        AF.request("https://api.openweathermap.org/data/2.5/weather?", parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                
                print(weather)
                
                self.receivedWeather = weather
                completition(weather)
            } catch {
                print("error")
            }
        }
            
        }
    
            
   
    func getWeather2(string: String, completition: @escaping(Weather) -> Void) {
          let url = "https://api.openweathermap.org/data/2.5/weather?q=" + string + "&appid=a0c15454e4511c5f6f347ad2fd72b355"
          let request = URLRequest(url: URL(string: url)!)
        print("начало метода")
          let task = URLSession.shared.dataTask(with: request) {
              data, response, error in
            DispatchQueue.main.async {
                print("клоужер")
              if let data = data, let weather = try? JSONDecoder().decode(Weather.self, from: data)
              {
              
                self.receivedWeather = weather.self
                completition(weather)
              }
              else {
              }
          }
          }
          task.resume()
        print("task")
        
    }

}
    

