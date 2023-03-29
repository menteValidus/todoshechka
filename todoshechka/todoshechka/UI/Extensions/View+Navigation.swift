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
        let isPresentedBinding = createBindingFrom(object, onDisappear: onDisappear)
        
        navigationDestination(isPresented: isPresentedBinding, destination: destination)
    }
    
    @ViewBuilder
    func fullScreenCover<Content: View>(
        _ object: AnyObject?,
        onDismiss: @escaping VoidCallback,
        content: @escaping () -> Content
    ) -> some View {
        let isPresentedBinding = createBindingFrom(object, onDisappear: onDismiss)
        
        fullScreenCover(isPresented: isPresentedBinding, content: content)
    }
    
    private func createBindingFrom(_ object: AnyObject?, onDisappear: @escaping VoidCallback) -> Binding<Bool> {
        Binding(
            get: {
                object != nil
            },
            set: { value in
                if !value {
                    onDisappear()
                }
            }
        )
    }
}
