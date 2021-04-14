//
//  NetworkManager.swift
//  StocksDemo
//
//  Created by Andrew Cheberyako on 14.04.2021.
//

import Foundation

protocol NetworkStocksManagerDelegate {
    func updateInterface(_: NetworkManager, with currentStoks: Stocks)
}


struct NetworkManager {
    
    var delgate: NetworkStocksManagerDelegate?
    
    func fetchCurrentAir( onFile: @escaping (Error) -> Void) {
        let urlString = "https://api.twelvedata.com/time_series?symbol=AAPL&interval=1min&apikey=a16e7f0adc7346e29e6eb9f8f9a00e19"
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task =  session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let currentAir =  self.parseJSON(withData: data, onFail: onFile) {
                    self.delgate?.updateInterface(self, with: currentAir)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data, onFail: @escaping(Error) -> Void) -> Stocks?  {
        
        let decoder = JSONDecoder()
        do {
            let currentStocksData = try decoder.decode(StocksData.self, from: data)
            guard let currentStocks = Stocks(stocksData: currentStocksData)  else {return nil}
            print(currentStocks)
            return currentStocks
        } catch let error  {
            print(error.localizedDescription)
            onFail(error)
        }
        return nil
        
    }
    
}
