//
//  StockListView.swift
//  Chart
//
//  Created by 심현지 on 11/23/24.
//

import SwiftUI

struct StockListView: View {
    @ObservedObject var viewModel: StockListViewModel
    
    var body: some View {
        List(viewModel.stocks) { stock in
            NavigationLink(destination: StockDetailView(stock: stock)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(stock.symbol)
                            .font(.headline)
                        Text(stock.name)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("$\(stock.price, specifier: "%.2f")")
                            .font(.headline)
                        Text("\(stock.change > 0 ? "+" : "")\(stock.change, specifier: "%.2f")%")
                            .font(.subheadline)
                            .foregroundColor(stock.change > 0 ? .green : .red)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .listStyle(PlainListStyle())
    }
}
