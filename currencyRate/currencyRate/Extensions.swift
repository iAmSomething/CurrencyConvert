//
//  Extensions.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import Foundation
extension Double {
    // 커스텀 숫자 포맷 함수
    var formatNumber:  String {
        let integerNumber = Int64(self)
        let eok = integerNumber / 100000000
        let man = (integerNumber % 100000000) / 10000
        let rest = integerNumber % 10000

        var result = ""
        if eok > 0 {
            result += "\(formatWithComma(Int(eok)))억 "
        }
        if man > 0 || eok > 0 {
            result += "\(formatWithComma(Int(man)))만 "
        }
        result += "\(formatWithComma(Int(rest)))"
        return result.trimmingCharacters(in: .whitespaces)
    }
    // 천 단위 구분 기호를 추가하는 함수
    func formatWithComma(_ number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

extension Double {
    var formattedString : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 2 // 소수점 이하 자릿수를 설정할 수 있습니다.
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
extension String {
    var doubleValue: Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.numberStyle = .decimal
        
        if let number = formatter.number(from: replacingOccurrences(of: ",", with: "")) {
            return number.doubleValue
        } else {
            return nil
        }
    }
}
