//
//  SettingView.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var viewModel: CurrencyViewModel
    @State private var searchText = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.bottom)
            
            List {
                ForEach(filteredCurrencies(searchText), id: \.self) { currency in
                    HStack {
                        Text("\(currency.flag ?? "") \(currency.name)")
                        Spacer()
                        Image(systemName: currency.stared ? "star.fill" : "star")
                            .foregroundStyle(Color.yellow)
                            .onTapGesture {
                                viewModel.didSelectCountry(type: currency)
                            }
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

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            Button(action: {
                withAnimation {
                    text = ""
                    UIApplication.shared.endEditing()
                }
            }) {
                if !text.isEmpty {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .opacity(text.isEmpty ? 0 : 1)
                }
            }
            .padding(.trailing, 8)
            .transition(.move(edge: .trailing))
            .animation(.default)
        }
        .padding(.horizontal)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#Preview {
   ContentView()
}
