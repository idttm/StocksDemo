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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var networkManager = NetworkManager()
    
    
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        networkManager.delgate = self
        networkManager.fetchCurrentAir { (error) in
            error.localizedDescription
        }
        let swipeRecognazer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeUpdate))
        swipeRecognazer.direction = .down
        view.addGestureRecognizer(swipeRecognazer)
        
       
    }
    
    @objc private func swipeUpdate(sender: UISwipeGestureRecognizer) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        networkManager.fetchCurrentAir { (error) in
            error.localizedDescription
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
       
        
    }
   
}


extension ViewController: NetworkStocksManagerDelegate {
    func updateInterface(_: NetworkManager, with currentStoks: Stocks) {
        DispatchQueue.main.async {
            
//            self.openLabel.text = currentStoks.valueOpen
            self.highLabel.text = currentStoks.high
            self.nameLabel.text = currentStoks.symbol
        }
    }
}

