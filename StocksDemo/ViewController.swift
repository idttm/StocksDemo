//
//  ViewController.swift
//  StocksDemo
//
//  Created by Andrew Cheberyako on 14.04.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delgate = self
        networkManager.fetchCurrentAir { (error) in
            error.localizedDescription
        }
        
    }


}
extension ViewController: NetworkStocksManagerDelegate {
    func updateInterface(_: NetworkManager, with currentStoks: Stocks) {
        DispatchQueue.main.async {
            
            self.openLabel.text = currentStoks.valueOpen
            self.highLabel.text = currentStoks.high
            self.nameLabel.text = currentStoks.symbol
        }
    }
}

