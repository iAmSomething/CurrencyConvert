//
//  CurrencyEntry.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import Foundation
import WidgetKit

struct CurrencyEntry: TimelineEntry {
    var date: Date
    var currency: currencyType
    var currencyRate: Double
    init(currency: currencyType) {
        self.currency = currency
        let (currentRate, date) = UserDefaultsManager.shared.loadData()
        self.date = date ?? Date()
        if let krw = currentRate?["KRW"],
           let base = currentRate?[currency.id] {
            
            self.currencyRate = krw / base
        }
        else {
            self.currencyRate = 0.0
        }
    }
}

