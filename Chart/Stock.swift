//
//  Stock.swift
//  Chart
//
//  Created by 심현지 on 11/23/24.
//

import Foundation

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let price: Double
    let change: Double
}
