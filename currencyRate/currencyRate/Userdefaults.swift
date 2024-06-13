//
//  Userdefaults.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import Foundation
class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let userDefaults = UserDefaults(suiteName: "group.thkim.currencyRate")
    private let dataKey = "myDataWithDate"

    struct DataWithDate: Codable {
        let data: [String: Double]
        let lastUpdated: Date
    }

    func saveData(_ data: [String: Double]) {
        let currentDate = Date()
        let dataWithDate = DataWithDate(data: data, lastUpdated: currentDate)
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(dataWithDate) {
            userDefaults?.set(encodedData, forKey: dataKey)
        }
    }

    func loadData() -> (data: [String: Double]?, lastUpdated: Date?) {
        if let savedData = userDefaults?.data(forKey: dataKey) {
            let decoder = JSONDecoder()
            if let loadedDataWithDate = try? decoder.decode(DataWithDate.self, from: savedData) {
                return (loadedDataWithDate.data, loadedDataWithDate.lastUpdated)
            }
        }
        return (nil, nil)
    }
    func saveCountry(_ data: [String]) {
        userDefaults?.set(data, forKey: "starredCurrency")
    }

    func fetchCountry() -> [String] {
        return userDefaults?.array(forKey: "starredCurrency") as? [String] ?? []
    }
    func currentResult() -> Int {
        return userDefaults?.integer(forKey: "currentResult") ?? 0
    }
    func setCurrentResult(num: Int) {
        userDefaults?.setValue(num, forKey: "currentResult")
    }
}
