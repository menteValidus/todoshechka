//
//  Created on 24.03.2023.
//

import Foundation

final class MainScreenViewModel: ObservableObject {
    
    @Published private(set) var welcomeMessage: String = ""
    
    private let dateGenerator: DateGenerator
    
    init(dateGenerator: @escaping DateGenerator = Date.init) {
        self.dateGenerator = dateGenerator
    }
    
    func start() {
        welcomeMessage = R.string.localizable.welcome_good_morning()
    }
}
