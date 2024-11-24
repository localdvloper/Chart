//
//  SearchView.swift
//  Chart
//
//  Created by 심현지 on 11/23/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search stocks...", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Button(action: onSearch) {
                Text("Search")
                    .foregroundColor(.blue)
            }
            .padding(.trailing)
        }
        .padding(.vertical, 5)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant("Apple"), onSearch: {})
    }
}
