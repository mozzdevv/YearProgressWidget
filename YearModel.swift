import Foundation

struct YearModel {
    let date: Date
    let calendar = Calendar.current
    
    // Core properties
    var year: Int {
        calendar.component(.year, from: date)
    }
    
    var totalDays: Int {
        return isLeapYear(year) ? 366 : 365
    }
    
    var daysPassed: Int {
        calendar.ordinality(of: .day, in: .year, for: date) ?? 0
    }
    
    var daysLeft: Int {
        totalDays - daysPassed
    }
    
    var percentage: Double {
        Double(daysPassed) / Double(totalDays)
    }
    
    var formattedPercentage: String {
        let percent = Int(percentage * 100)
        return "\(percent)%"
    }
    
    // Helper to check for leap year
    private func isLeapYear(_ year: Int) -> Bool {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    // Helper to get day status (passed vs future) for grid
    func isDayPassed(dayIndex: Int) -> Bool {
        // dayIndex is 0-based (0 to 364/365)
        // daysPassed is 1-based (1st day is 1)
        // So if daysPassed is 5, indices 0,1,2,3,4 are passed.
        return dayIndex < daysPassed
    }
}
