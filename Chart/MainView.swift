//
//  MainView.swift
//  Chart
//
//  Created by 심현지 on 11/23/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = StockListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchView(searchText: $searchText, onSearch: performSearch)
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .top)  // 상단에 배치
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .top)  // 상단에 배치
                } else {
                    StockListView(viewModel: viewModel)
                        .padding(.top) // 상단 여백 추가
                }
                
                Spacer()  // 하단에 여백을 추가하여 뷰를 상단에 고정
            }
            .navigationTitle("Stock Tracker")
            .onAppear {
               viewModel.fetchStocks()
            }
        }
    }
    
    private func performSearch() {
        viewModel.searchStocks(query: searchText)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
