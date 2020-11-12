//
//  WidgetTest.swift
//  WidgetTest
//
//  Created by master on 2020/11/12.
//

import WidgetKit
import SwiftUI
import Intents

// Provider: 위젯을 새로고침할 타임라인을 결정하는 객체
// 위젯 업데이트할 미래 날짜를 주면 시스템이 새로고침 프로세스를 최적화.
struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

// Widget 컨텐츠를 표시해줄 SwiftUI View
struct WidgetTestEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: Provider.Entry
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            Text("systemSmall")
        case .systemMedium:
            Text("systemMedium")
        case .systemLarge:
            Text("systemLarge")
        @unknown default:
            Text("unknown")
        }
    }

}

// Widget Protocol: Widget의 컨텐츠를 나타내는 configuration 타입
@main
struct WidgetTest: Widget {
    let kind: String = "WidgetTest"

    // WidgetConfiguration: Widget의 content를 나타내는 타입
    var body: some WidgetConfiguration {
        /*
         WidgetConfiguration Type
         1. IntentConfiguration
            - 날씨위젯, 미리알림 위젯
         2. StaticConfiguration: 사용자가 구성할 수 있는 프로퍼티가 없는 위젯
            - 주식시장 위젯, 뉴스위젯
         */
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetTestEntryView(entry: entry)
            // kind: Widget의 고유 문자열(위젯 식별용)
            // provider: 위젯을 새로고침할 타임라인을 결정하는 객체(새로고침 프로세스 최적화)
            // entry
        }
        .configurationDisplayName("My Widget") // 위젯 추가/편집 시 표시되는 이름
        .description("This is an example widget.") // 위젯 추가/편집 시 표시되는 설명
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge]) // 위젯 제공 크기
    }
}

struct WidgetTest_Previews: PreviewProvider {
    static var previews: some View {
        WidgetTestEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
