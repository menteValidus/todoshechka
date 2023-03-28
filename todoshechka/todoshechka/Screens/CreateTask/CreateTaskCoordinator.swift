//
//  Created on 26.03.2023.
//

import SwiftUI

struct CreateTaskCoordinatorView: View {
    @StateObject
    private var object = CreateTaskCoordinatorObject()
    
    var body: some View {
        CreateTask()
    }
}

private final class CreateTaskCoordinatorObject: ObservableObject {
    
}
