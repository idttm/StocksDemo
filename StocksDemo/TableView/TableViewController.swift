//
//  TableViewController.swift
//  StocksDemo
//
//  Created by Andrew Cheberyako on 16.04.2021.
//

import UIKit

class TableViewController: UITableViewController {

    var arrayStocks = [Stocks]()
    
    var networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delgate = self
        networkManager.fetchCurrentAir { (error) in
            error.localizedDescription
        }
//        fetchData()
    
    }
    
    @IBAction func updateDataStocks(_ sender: UIRefreshControl) {
        networkManager.delgate = self
        networkManager.fetchCurrentAir { (error) in
            error.localizedDescription
        }
        func updateInterface(_: NetworkManager, with currentStoks: Stocks) {
            arrayStocks.append(currentStoks)
            
        }
        
        func updateTableView(cell: UITableViewCell, for indexPath: IndexPath) {
            
            let indexStocks = arrayStocks[indexPath.row]
            
            let arrayStocks = indexStocks.valueOpen
            var currentStocks: String = ""
           
            for valueOpen in arrayStocks {
                var indext = 0
                currentStocks = arrayStocks[indext].valueOpen
                indext += 1
                }
            
            cell.textLabel?.text = currentStocks
            
            
            
        
        }
        sender.endRefreshing()
        tableView.reloadData()
        
        
    }
    
    
    
//    func fetchData() {
//        let jsonUrlString = "https://api.twelvedata.com/time_series?symbol=AAPL&interval=1min&apikey=a16e7f0adc7346e29e6eb9f8f9a00e19"
//        guard let url = URL(string: jsonUrlString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            guard let data = data else {return}
//            let decoder = JSONDecoder()
//            let strintData = String(data: data, encoding: .utf8)
//            print(strintData)
//            do {
//                let stocksdata = try decoder.decode(StocksData.self, from: data)
//                print(stocksdata)
//            } catch let error {
//                print(error.localizedDescription)
//            }
//
//        }.resume()
//    }
    
   
    
    

    // MARK: - Table view data source
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayStocks.count == 0 {
            return 1
        } else {
            return arrayStocks.count + 1
            print(arrayStocks.count)
        }
    
    
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
            self.updateTableView(cell: cell, for: indexPath)
        })
            
          
        return cell
        
    }
    
    
}
extension TableViewController: NetworkStocksManagerDelegate {
    
    func updateInterface(_: NetworkManager, with currentStoks: Stocks) {
        arrayStocks.append(currentStoks)
        
    }
    
    func updateTableView(cell: UITableViewCell, for indexPath: IndexPath) {
        
        let indexStocks = arrayStocks[indexPath.row]
        let arrayStocks = indexStocks.valueOpen
        var currentStocks: String = ""
//        print(arrayStocks)
        for valueOpen in arrayStocks {
            var indext = 0
            currentStocks = arrayStocks[indext].valueOpen
            indext += 1
            }
        
        cell.textLabel?.text = currentStocks
        
        
    
    }
}
