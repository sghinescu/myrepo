import WidgetKit
import SwiftUI

struct TimeZoneAppWidget: Widget {
    let kind: String = "TimeZoneAppWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeZoneWidgetProvider()) { entry in
            TimeZoneAppWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("World Clocks")
        .description("Display your selected timezone times.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct TimeZoneWidgetProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> TimeZoneWidgetEntry {
        TimeZoneWidgetEntry(date: Date(), timeZones: [
            TimeZoneData(name: "New York", identifier: "America/New_York", isSelected: true),
            TimeZoneData(name: "London", identifier: "Europe/London", isSelected: true),
            TimeZoneData(name: "Tokyo", identifier: "Asia/Tokyo", isSelected: true)
        ])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (TimeZoneWidgetEntry) -> ()) {
        let timeZones = TimeZoneManager.shared.selectedTimeZones
        let entry = TimeZoneWidgetEntry(date: Date(), timeZones: timeZones.isEmpty ? placeholder(in: context).timeZones : timeZones)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<TimeZoneWidgetEntry>) -> ()) {
        let timeZones = TimeZoneManager.shared.selectedTimeZones
        let entry = TimeZoneWidgetEntry(date: Date(), timeZones: timeZones)
        
        // Refresh every second to update the time
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(1)))
        completion(timeline)
    }
}

struct TimeZoneWidgetEntry: TimelineEntry {
    let date: Date
    let timeZones: [TimeZoneData]
}

struct TimeZoneAppWidgetEntryView: View {
    var entry: TimeZoneWidgetProvider.Entry
    
    var body: some View {
        VStack(spacing: 8) {
            Text("World Clocks")
                .font(.headline)
                .padding(.bottom, 4)
            
            ForEach(entry.timeZones.prefix(3)) { timeZone in
                TimeZoneRow(timeZone: timeZone, currentDate: entry.date)
            }
            
            if entry.timeZones.count > 3 {
                Text("+\(entry.timeZones.count - 3) more")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

struct TimeZoneRow: View {
    let timeZone: TimeZoneData
    let currentDate: Date
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timeZone.identifier)
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timeZone.identifier)
        formatter.dateFormat = "EEE, MMM d"
        return formatter
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(timeZone.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(dateFormatter.string(from: currentDate))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(timeFormatter.string(from: currentDate))
                .font(.title3)
                .fontWeight(.bold)
                .monospacedDigit()
        }
    }
}

// Preview
struct TimeZoneAppWidget_Previews: PreviewProvider {
    static var previews: some View {
        TimeZoneAppWidgetEntryView(entry: TimeZoneWidgetEntry(
            date: Date(),
            timeZones: [
                TimeZoneData(name: "New York", identifier: "America/New_York", isSelected: true),
                TimeZoneData(name: "London", identifier: "Europe/London", isSelected: true),
                TimeZoneData(name: "Tokyo", identifier: "Asia/Tokyo", isSelected: true)
            ]
        ))
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
