//
//  AppIntent.swift
//  currencyRateWidget
//
//  Created by 김태훈 on 6/6/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.

    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
struct insertNumberIntent: AppIntent {
    static public var title: LocalizedStringResource = "insertNumber"
    @Parameter(title: "number")
    var number: Int
    
    public func perform() async throws -> some IntentResult {
        print(number)
        Calculator.addNum(num: number)
        return .result(value: number)
    }
}
