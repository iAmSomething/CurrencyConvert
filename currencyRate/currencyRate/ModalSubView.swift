//
//  ModalSubView.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import Foundation
import SwiftUI
struct ModalSubView: View {
    @EnvironmentObject var viewModel: CurrencyViewModel
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @Binding var current: currencyType
    @State var isSymbol: Bool = false
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.vertical)
            if isSymbol {
                Button(action: {
                    current = .init(id: "KRW")
                    dismiss()
                }, label: {
                    HStack {
                        Text("🇰🇷 한국")
                            .bold()
                            .padding()
                    }
                }).frame(maxWidth: .infinity)
            }
            List {
                ForEach(filteredCurrencies(searchText), id: \.self) { currency in
                    HStack {
                        Text("\(currency.flag ?? "") \(currency.name)")
                        Spacer()
                        Image(systemName: currency.stared ? "star.fill" : "star")
                            .foregroundStyle(Color.yellow)
                            
                    }
                    .onTapGesture {
                        current = currency
                        dismiss()
                    }
                }
            }
        }.navigationTitle("설정")
    }
    private func filteredCurrencies(_ searchText: String) -> [currencyType] {
        if searchText.isEmpty {
            return viewModel.currencyList.sorted()
        } else {
            return viewModel.currencyList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
#Preview {
   ContentView()
}
