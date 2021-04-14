//
//  Stocks.swift
//  StocksDemo
//
//  Created by Andrew Cheberyako on 14.04.2021.
//

import Foundation

struct Stocks {
    
    let symbol: String
    let valueOpen: String
    let high: String
    
    init?(stocksData: StocksData) {
        symbol = stocksData.meta.symbol
        var valueOpen1 = ""
        for valueOpen in stocksData.values {
            valueOpen1 = valueOpen.valueOpen
        }
        valueOpen = valueOpen1
        var high1 = " "
        for high in stocksData.values {
            high1 = high.high
        }
        high = high1
    }
    
}
