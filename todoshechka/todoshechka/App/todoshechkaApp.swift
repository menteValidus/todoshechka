//
//  Created on 22.03.2023.
//

import SwiftUI

@main
struct todoshechkaApp: App {
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView()
                .preferredColorScheme(.dark)
        }
    }
}
