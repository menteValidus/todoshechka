//
//  Created on 27.03.2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func navigationDestination<Content: View>(
        _ object: AnyObject?,
        onDisappear: @escaping VoidCallback,
        destination: () -> Content
    ) -> some View {
        let isPresentedBinding: Binding<Bool> = Binding(
            get: {
                object != nil
            },
            set: { value in
                if !value {
                    onDisappear()
                }
            })
        navigationDestination(isPresented: isPresentedBinding, destination: destination)
    }
}
