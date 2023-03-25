//
//  Created on 25.03.2023.
//

import Foundation

extension Calendar {
    func date(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date? {
        date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute))
    }
}
