import Foundation

struct TimeZoneData: Identifiable, Codable {
    let id: String
    let name: String
    let identifier: String
    var isSelected: Bool
    
    init(id: String = UUID().uuidString, name: String, identifier: String, isSelected: Bool = false) {
        self.id = id
        self.name = name
        self.identifier = identifier
        self.isSelected = isSelected
    }
}

class TimeZoneManager {
    static let shared = TimeZoneManager()
    
    private let userDefaults = UserDefaults(suiteName: "group.com.yourapp.TimeZoneApp")
    private let selectedTimeZonesKey = "selectedTimeZones"
    
    private init() {}
    
    // Common timezones for easy selection
    let commonTimeZones: [TimeZoneData] = [
        TimeZoneData(name: "New York", identifier: "America/New_York"),
        TimeZoneData(name: "Los Angeles", identifier: "America/Los_Angeles"),
        TimeZoneData(name: "Chicago", identifier: "America/Chicago"),
        TimeZoneData(name: "London", identifier: "Europe/London"),
        TimeZoneData(name: "Paris", identifier: "Europe/Paris"),
        TimeZoneData(name: "Berlin", identifier: "Europe/Berlin"),
        TimeZoneData(name: "Tokyo", identifier: "Asia/Tokyo"),
        TimeZoneData(name: "Sydney", identifier: "Australia/Sydney"),
        TimeZoneData(name: "Beijing", identifier: "Asia/Shanghai"),
        TimeZoneData(name: "Moscow", identifier: "Europe/Moscow"),
        TimeZoneData(name: "Dubai", identifier: "Asia/Dubai"),
        TimeZoneData(name: "Singapore", identifier: "Asia/Singapore"),
        TimeZoneData(name: "Hong Kong", identifier: "Asia/Hong_Kong"),
        TimeZoneData(name: "Toronto", identifier: "America/Toronto"),
        TimeZoneData(name: "São Paulo", identifier: "America/Sao_Paulo"),
        TimeZoneData(name: "Mumbai", identifier: "Asia/Kolkata"),
        TimeZoneData(name: "Cairo", identifier: "Africa/Cairo"),
        TimeZoneData(name: "Cape Town", identifier: "Africa/Johannesburg"),
        TimeZoneData(name: "Auckland", identifier: "Pacific/Auckland"),
        TimeZoneData(name: "Seoul", identifier: "Asia/Seoul")
    ]
    
    var selectedTimeZones: [TimeZoneData] {
        get {
            if let data = userDefaults?.data(forKey: selectedTimeZonesKey),
               let decoded = try? JSONDecoder().decode([TimeZoneData].self, from: data) {
                return decoded
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaults?.set(data, forKey: selectedTimeZonesKey)
            }
        }
    }
    
    func addTimeZone(_ timeZone: TimeZoneData) {
        var current = selectedTimeZones
        if current.count >= 6 {
            current.removeLast()
        }
        current.append(timeZone)
        selectedTimeZones = current
    }
    
    func removeTimeZone(_ timeZone: TimeZoneData) {
        var current = selectedTimeZones
        if let index = current.firstIndex(where: { $0.identifier == timeZone.identifier }) {
            current.remove(at: index)
            selectedTimeZones = current
        }
    }
    
    func toggleTimeZone(_ timeZone: TimeZoneData) {
        var current = selectedTimeZones
        if let index = current.firstIndex(where: { $0.identifier == timeZone.identifier }) {
            current.remove(at: index)
        } else {
            if current.count >= 6 {
                current.removeLast()
            }
            current.append(timeZone)
        }
        selectedTimeZones = current
    }
    
    func getCurrentTime(for identifier: String) -> Date {
        let timeZone = TimeZone(identifier: identifier) ?? TimeZone.current
        let calendar = Calendar.current
        return Date()
    }
    
    func getFormattedTime(for identifier: String, date: Date = Date()) -> String {
        let timeZone = TimeZone(identifier: identifier) ?? TimeZone.current
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func getFormattedDateTime(for identifier: String, date: Date = Date()) -> String {
        let timeZone = TimeZone(identifier: identifier) ?? TimeZone.current
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "EEE, MMM d, yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func getTimeDifference(from baseIdentifier: String, to targetIdentifier: String) -> String {
        let baseTimeZone = TimeZone(identifier: baseIdentifier) ?? TimeZone.current
        let targetTimeZone = TimeZone(identifier: targetIdentifier) ?? TimeZone.current
        
        let baseOffset = baseTimeZone.secondsFromGMT(for: Date())
        let targetOffset = targetTimeZone.secondsFromGMT(for: Date())
        
        let difference = targetOffset - baseOffset
        let hours = difference / 3600
        
        if hours == 0 {
            return "Same time"
        } else if hours > 0 {
            return "+\(hours)h"
        } else {
            return "\(hours)h"
        }
    }
}
