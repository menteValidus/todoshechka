//
//  Created on 24.03.2023.
//

import Foundation

final class RelativeWeekDayFormatter {
    
    private let calendar: Calendar
    private let todayGenerator: DateGenerator
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter
    }
    
    init(calendar: Calendar = .current, todayGenerator: @escaping DateGenerator = Date.init) {
        self.calendar = calendar
        self.todayGenerator = todayGenerator
    }
    
    func string(from date: Date) -> String? {
        let components = calendar.dateComponents([.day], from: todayGenerator(), to: date)
        guard let day = components.day else {
           return nil
        }
        
        let relativeDateFormatted = dateFormatter.string(from: date)
        
        switch day {
        case 0:
            return R.string.localizable.relative_date_today_template.callAsFunction(relativeDateFormatted)
        case 1:
            return R.string.localizable.relative_date_tomorrow_template.callAsFunction(relativeDateFormatted)
        case -1:
            return R.string.localizable.relative_date_yesterday_template.callAsFunction(relativeDateFormatted)
        default:
            return relativeDateFormatted
        }
    }
}
