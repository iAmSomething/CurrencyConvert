//
//  currencyRateWidget.swift
//  currencyRateWidget
//
//  Created by 김태훈 on 6/6/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> CurrencyEntry {
        CurrencyEntry(currency: .init(id: "VND"))
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> CurrencyEntry {
        CurrencyEntry(currency: .init(id: "VND"))
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<CurrencyEntry> {
        var entries: [CurrencyEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let saved = UserDefaultsManager.shared.fetchCountry()
        let currencyTimeline: [CurrencyEntry] = Currency.allCases
            .filter{ id in
                saved.contains(where: {$0 == id.rawValue})
            }
            .map{.init(currency: .init(id: $0.rawValue, saved: saved))}
        var currentDate = Date()
        for var entry in currencyTimeline {
            entry.date = currentDate
            currentDate += 30
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}


struct currencyRateWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    @State var price: Double = 1.0
    var body: some View {
        VStack {
            Text("환율 : \(entry.currencyRate)")
                .bold()
            Text("\(price * entry.currencyRate) \(entry.currency.flag ?? "") \(entry.currency.name) \(entry.currency.currencyName)")
                HStack {
                    Button {
                        price = 1000
                    } label: {
                        Text("1,000원")
                    }
                    Button {
                        price = 3000
                    } label: {
                        Text("3,000원")
                    }
                    Button {
                        price = 5000
                    } label: {
                        Text("5,000원")
                    }
            }

        }
    }
}

struct currencyRateWidget: Widget {
    let kind: String = "currencyRateWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            currencyRateWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                
        }.supportedFamilies([.systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemMedium) {
    currencyRateWidget()
} timeline: {
    CurrencyEntry(currency: .init(id: "VND"))
    CurrencyEntry(currency: .init(id: "USD"))
    CurrencyEntry(currency: .init(id: "JPY"))
}
