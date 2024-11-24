//
//  StockDetailView.swift
//  Chart
//
//  Created by 심현지 on 11/23/24.
//

import SwiftUI

struct StockDetailView: View {
    let stock: Stock
    @State private var chartData: [Double] = [] // 차트 데이터를 저장
    @State private var isLoading = true         // 로딩 상태
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
                    .padding()
            } else {
                // 차트 표시
                ChartView(data: chartData)
                    .frame(height: 300)
                    .padding()
                
                // 종목 정보
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Symbol:")
                            .font(.headline)
                        Spacer()
                        Text(stock.symbol)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Current Price:")
                            .font(.headline)
                        Spacer()
                        Text("$\(stock.price, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Change:")
                            .font(.headline)
                        Spacer()
                        Text("\(stock.change > 0 ? "+" : "")\(stock.change, specifier: "%.2f")%")
                            .font(.subheadline)
                            .foregroundColor(stock.change > 0 ? .green : .red)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                Spacer()
            }
        }
        .navigationTitle(stock.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchChartData()
        }
    }
    
    // 차트 데이터를 가져오는 메서드
    func fetchChartData() {
        // 샘플 차트 데이터 생성 (Alpaca API 연동 시 교체 필요)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.chartData = [100, 102, 105, 103, 110, 108, 112, 115]
            self.isLoading = false
        }
    }
}

struct ChartView: View {
    let data: [Double]
    
    var body: some View {
        GeometryReader { geometry in
            let maxValue = data.max() ?? 1
            let minValue = data.min() ?? 0
            let height = geometry.size.height
            let width = geometry.size.width / CGFloat(data.count - 1)
            
            Path { path in
                for index in data.indices {
                    let x = CGFloat(index) * width
                    let y = height - (CGFloat(data[index] - minValue) / CGFloat(maxValue - minValue) * height)
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(stock: Stock(symbol: "AAPL", name: "Apple", price: 185.25, change: 1.25))
    }
}
