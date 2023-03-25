//
//  Created on 24.03.2023.
//

import Foundation

final class RelativeWeekDayFormatter {
    
    private let calendar: Calendar
    private let todayGenerator: DateGenerator
    
    init(calendar: Calendar = .current, todayGenerator: @escaping DateGenerator = Date.init) {
        self.calendar = calendar
        self.todayGenerator = todayGenerator
    }
    
    func string(from date: Date) -> String? {
        let components = calendar.dateComponents([.day], from: todayGenerator(), to: date)
        guard let day = components.day else {
           return nil
        }
        
        switch day {
        case 0:
            return "Today"
        case 1:
            return "Tomorrow"
        case -1:
            return "Yesterday"
        default:
            return "hehe"
        }
    }
}
