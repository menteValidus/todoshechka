//
//  Created on 07.04.23.
//

import SwiftUI

private var animationDuration: CGFloat { 0.2 }

private struct DefaultAnimationModifier<Value: Equatable>: ViewModifier {
    let value: Value
    
    func body(content: Content) -> some View {
        content.animation(
            .easeInOut(duration: animationDuration),
            value: value
        )
    }
}

extension View {
    func defaultAnimation<Value: Equatable>(value: Value) -> some View {
        modifier(DefaultAnimationModifier(value: value))
    }
}

extension AnyTransition {
    func defaultAnimation() -> AnyTransition {
        animation(.easeInOut(duration: animationDuration))
    }
}
