//
//  currencyRateWidgetLiveActivity.swift
//  currencyRateWidget
//
//  Created by 김태훈 on 6/6/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct currencyRateWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct currencyRateWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: currencyRateWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
            
        }
    }
}

extension currencyRateWidgetAttributes {
    fileprivate static var preview: currencyRateWidgetAttributes {
        currencyRateWidgetAttributes(name: "World")
    }
}

extension currencyRateWidgetAttributes.ContentState {
    fileprivate static var smiley: currencyRateWidgetAttributes.ContentState {
        currencyRateWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: currencyRateWidgetAttributes.ContentState {
         currencyRateWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: currencyRateWidgetAttributes.preview) {
   currencyRateWidgetLiveActivity()
} contentStates: {
    currencyRateWidgetAttributes.ContentState.smiley
    currencyRateWidgetAttributes.ContentState.starEyes
}
