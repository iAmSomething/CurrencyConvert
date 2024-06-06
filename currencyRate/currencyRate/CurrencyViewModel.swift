//
//  CurrencyViewModel.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import Foundation
import Combine

final class CurrencyViewModel: ObservableObject {
    @Published var currencyList: [currencyType] = []
    private let httpManager = HTTPManager<ResponseModel>(apiType: .getLatestCurrency)
    @Published var baseCurrency: currencyType = .init(id: "USD")
    @Published var symbolCurrency: currencyType = .init(id: "KRW")
    @Published var digit: String = ""
    @Published var result: [String: Double]? = nil
    init() {
        Task{@MainActor in
            await setupList()
            await fetchData()
        }
        
    }
    private func setupList() async {
        await MainActor.run {
            let saved = UserDefaultsManager.shared.fetchCountry()
            self.currencyList = Currency.allCases
                .map{.init(id: $0.rawValue, saved: saved)}
            if let base  = self.currencyList.first(where: {$0.stared}) {
                baseCurrency = base
            }
        }
    }
    private func fetchData() async {
        let (loadedData, lastUpdated) = UserDefaultsManager.shared.loadData()
        if let data = loadedData,
           let updated = lastUpdated {
            await MainActor.run {
                self.result = data
            }
        } else {
            
            let response = await httpManager.fetchData()
            switch response {
            case .success(let data) :
                await MainActor.run {
                    self.result = data.rates
                    if let res = self.result {
                        UserDefaultsManager.shared.saveData(res)
                    }
                }
            case .failure(let error) :
                print(error.errorDescription)
            }
        }
    }
}
//MARK: - input
extension CurrencyViewModel {
    func digitDouble() -> Double{
        if let val = digit.doubleValue {
            return val
        } else { return 0.0}
    }
    func didSelectCountry(type: currencyType) {
        guard var t = self.currencyList.first(where: {$0 == type}) else {return}
        self.currencyList.removeAll(where: {$0 == type})
        t.selection()
        self.currencyList.append(t)
        
        
        let saved = self.currencyList.filter{$0.stared}
        UserDefaultsManager.shared.saveCountry(saved.map{$0.id})
    }
    func didSetCurrncy() {
        //            Task { @MainActor in
        //                let response = await httpManager.fetchData()
        //                switch response {
        //                case .success(let data) :
        //                    self.result = data.rates
        //                case .failure(let error) :
        //                    print(error.errorDescription)
        //                }
        //            }
    }
    
}
//MARK: - API
extension CurrencyViewModel {
    
}
