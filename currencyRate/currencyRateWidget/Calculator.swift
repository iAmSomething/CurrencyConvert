//
//  Calculator.swift
//  currencyRate
//
//  Created by 김태훈 on 6/12/24.
//
import SwiftUI
import AppIntents
import WidgetKit

class Calculator {
    static func addNum(num: Int) {
        UserDefaultsManager.shared.setCurrentResult(num: num)
    }
    static func currentNum() -> Int {
        UserDefaultsManager.shared.currentResult()
    }
}
