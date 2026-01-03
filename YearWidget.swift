import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let model: YearModel
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let date = Date()
        return SimpleEntry(date: date, model: YearModel(date: date))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let date = Date()
        let entry = SimpleEntry(date: date, model: YearModel(date: date))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        
        // Refresh at the start of the next day
        let calendar = Calendar.current
        let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        let startOfNextDay = calendar.startOfDay(for: nextDay)
        
        let entry = SimpleEntry(date: currentDate, model: YearModel(date: currentDate))
        let timeline = Timeline(entries: [entry], policy: .after(startOfNextDay))
        completion(timeline)
    }
}

struct YearWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemLarge:
            LargeWidgetView(model: entry.model)
        case .accessoryRectangular:
            LockScreenWidgetView(model: entry.model)
        default:
            // Fallback for other sizes if enabled inadvertently
            VStack {
                Text(entry.model.formattedPercentage)
                Text("left")
            }
        }
    }
}

struct LargeWidgetView: View {
    let model: YearModel
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer()
                    Text(String(model.year))
                        .font(.custom("Palatino-Roman", size: 20))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.bottom, 8)
                
                // Grid
                // Adjusted for widget size (fewer columns might be needed depending on device, but 18 usually fits large)
                GeometryReader { geo in
                    LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 8, maximum: 12), spacing: 5), count: 18), spacing: 5) {
                        ForEach(0..<model.totalDays, id: \.self) { index in
                            Circle()
                                .fill(model.isDayPassed(dayIndex: index) ? Color(red: 0.5, green: 0.6, blue: 1.0) : Color.gray.opacity(0.3))
                                .frame(width: 6, height: 6) // Smaller text for widget
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.horizontal, 16)
                
                // Footer
                HStack(spacing: 4) {
                    Text("\(model.daysLeft)d left")
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                    Text("·")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text(model.formattedPercentage)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }
                .padding(.bottom, 16)
            }
        }
        .containerBackground(for: .widget) {
             Color.black
        }
    }
}

struct LockScreenWidgetView: View {
    let model: YearModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Year Progress")
                .font(.caption)
                .bold()
            ProgressView(value: model.percentage) {
                Text(model.formattedPercentage + " gone")
                    .font(.caption2)
            }
        }
        .containerBackground(for: .widget) {
            Color.black.opacity(0.2)
        }
    }
}

struct YearWidget: Widget {
    let kind: String = "YearWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            YearWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Year Progress")
        .description("Visualizes the year in dots.")
        .supportedFamilies([.systemLarge, .accessoryRectangular]) // Added accessoryRectangular for Lock Screen support
    }
}
