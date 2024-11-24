//
//  StockListViewModel.swift
//  Chart
//
//  Created by 심현지 on 11/23/24.
//

import Foundation
import Combine

class StockListViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var allStocks: [Stock] = []  // 원본 데이터 저장
    private var cancellables = Set<AnyCancellable>()
    
    func fetchStocks() {
        isLoading = true
        errorMessage = nil
        
        // 예: Mock 데이터
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let sampleStocks = [
                Stock(symbol: "AAPL", name: "Apple", price: 185.25, change: 1.25),
                Stock(symbol: "TSLA", name: "Tesla", price: 245.30, change: -2.30),
                Stock(symbol: "AMZN", name: "Amazon", price: 134.70, change: 0.95),
                Stock(symbol: "MSFT", name: "Microsoft", price: 314.90, change: 2.15)
            ]
            
            self.allStocks = sampleStocks  // 원본 데이터를 저장
            self.stocks = sampleStocks     // 초기 데이터
            self.isLoading = false
        }
    }
    
    func searchStocks(query: String) {
        if query.isEmpty {
            self.stocks = allStocks  // 검색어가 없으면 원본 데이터로 복원
        } else {
            self.stocks = allStocks.filter { stock in
                stock.symbol.lowercased().contains(query.lowercased()) ||
                stock.name.lowercased().contains(query.lowercased())
            }
        }
    }
}
