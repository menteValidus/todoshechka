//
//  Created on 19.04.23.
//

import Foundation

final class DateToDeadlineModelMapper {
    private lazy var deadlineDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter
    }()
    
    private lazy var deadlineTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }()
    
    func map(_ date: Date) -> DeadlinePicker.Model {
        .init(
            rawDate: date,
            formattedTime: deadlineTimeFormatter.string(from: date),
            formattedDate: deadlineDateFormatter.string(from: date)
        )
    }
}
