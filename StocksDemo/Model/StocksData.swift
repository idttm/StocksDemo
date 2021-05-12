//
//  StocksData.swift
//  StocksDemo
//
//  Created by Andrew Cheberyako on 14.04.2021.
//


import Foundation

struct StocksData: Codable {
    let meta: Meta
    let values: [Value]
    let status: String
    
    enum TopKodingCase: String, CodingKey {
        case meta
        case values
        case status
    }
}

struct Meta: Codable {
    let symbol, interval, currency, exchangeTimezone: String
    let exchange, type: String

    enum CodingKeys: String, CodingKey {
        case symbol, interval, currency
        case exchangeTimezone = "exchange_timezone"
        case exchange, type
    }
}

struct Value: Codable {
    let datetime, valueOpen, high, low: String
    let close, volume: String

    enum CodingKeys: String, CodingKey {
        case datetime
        case valueOpen = "open"
        case high, low, close, volume
    }
}



