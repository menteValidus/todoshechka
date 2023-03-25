//
//  Created on 24.03.2023.
//

import Foundation

final class MainScreenViewModel: ObservableObject {
    
    @Published private(set) var welcomeMessage: String = ""
    @Published private(set) var selectedRelativeDate: String = ""
    @Published private(set) var selectedFormattedDate: String = ""
    
    private let dateGenerator: DateGenerator
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }
    
    init(dateGenerator: @escaping DateGenerator = Date.init) {
        self.dateGenerator = dateGenerator
    }
    
    func start() {
        welcomeMessage = R.string.localizable.welcome_good_morning()
        
        let relativeWeekDayFormatter = RelativeWeekDayFormatter(todayGenerator: dateGenerator)
        selectedRelativeDate = relativeWeekDayFormatter.string(from: dateGenerator()) ?? ""
        selectedFormattedDate = dateFormatter.string(from: dateGenerator())
    }
}
