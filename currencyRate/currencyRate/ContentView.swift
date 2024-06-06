//
//  ContentView.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CurrencyViewModel = .init()
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    @State private var isEditing: Bool = false
    @State private var baseSelectioin: Bool = false
    @State private var symbolSelectioin: Bool = false
    var body: some View {
        NavigationStack {
            
            HStack {
                Spacer()
                NavigationLink("설정", destination: SettingView().environmentObject(viewModel))
                    .padding()
            }.frame(maxHeight: 50)
            VStack {
                Text("환율 계산기")
                    .bold()
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                    .padding()
                    .padding(.bottom, 50)
                HStack {
                    if !viewModel.digit.isEmpty {
                        Text("\(viewModel.digit)")
                            .bold()
                    } else {
                        Text("금액을 입력해주세요")
                            .bold()
                            .foregroundStyle(Color.gray)
                    }
                    Spacer()
                        Button(action: {
                            self.baseSelectioin.toggle()
                        }, label: {
                            Text("\(viewModel.baseCurrency.flag ?? "") \(viewModel.baseCurrency.name) \(viewModel.baseCurrency.currencyName.addUn())")
                                .bold()
                        })
                    
                }
                .padding(.bottom)
                HStack {
                    
                    if let res = viewModel.result {
                        let base = res[viewModel.baseCurrency.id] ?? 1.0
                        let symbol = res[viewModel.symbolCurrency.id] ?? 1.0
                        let totalVal = (symbol / base) * (viewModel.digitDouble())
                        let formattedTotalVal = totalVal.formatNumber
                        
                        Text("\(formattedTotalVal) \(viewModel.symbolCurrency.currencyName)")
                            .bold()
                    }
                    Spacer()
                    Button(action: {
                        self.symbolSelectioin.toggle()
                    }, label: {
                        Text("\(viewModel.symbolCurrency.flag ?? "") \(viewModel.symbolCurrency.name) \(viewModel.symbolCurrency.currencyName)입니다")
                            .bold()
                    })
                }.padding(.bottom)

                if let res = viewModel.result {
                    let base = res[viewModel.baseCurrency.id] ?? 1.0
                    let symbol = res[viewModel.symbolCurrency.id] ?? 1.0
                    let totalVal = (symbol / base) * (viewModel.digitDouble())
                    let formattedTotalVal = totalVal.formatNumber
                    Text("1 \(viewModel.baseCurrency.currencyName) = \((symbol/base).formattedString)\(viewModel.symbolCurrency.currencyName) ")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            if !viewModel.digit.isEmpty {
                HStack {
                    Button("만") {
                        if let doubleValue = viewModel.digit.doubleValue {
                            viewModel.digit = (doubleValue * 10000).formattedString
                        }
                    }
                    .bold()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    Button("천") {
                        if let doubleValue = viewModel.digit.doubleValue {
                            viewModel.digit = (doubleValue * 1000).formattedString
                        }
                    }
                    .bold()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)

                    Button("백") {
                        if let doubleValue = viewModel.digit.doubleValue {
                            viewModel.digit = (doubleValue * 100).formattedString
                        }
                    }
                    .bold()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)

                    Spacer()
                    Button("전부 삭제") {
                        viewModel.digit = ""
                    }
                    .bold()
                    .foregroundStyle(Color.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
            }
            CustomKeyboardView(inputValue: $viewModel.digit)
                .padding(.top)
                .frame(maxHeight: UIScreen.main.bounds.height / 2.0)

        }
        .sheet(isPresented: $baseSelectioin, content: {
            ModalSubView(current: $viewModel.baseCurrency)
                .presentationDetents([.medium])
                .environmentObject(viewModel)
        })
        .sheet(isPresented: $symbolSelectioin, content: {
            ModalSubView(current: $viewModel.symbolCurrency, isSymbol: true)
                .presentationDetents([.medium])
                .environmentObject(viewModel)
        })
        
    }
}



#Preview {
    ContentView()
}
