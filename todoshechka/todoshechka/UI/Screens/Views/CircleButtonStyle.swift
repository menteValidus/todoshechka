//
//  Created on 28.03.23.
//

import SwiftUI

struct CircleButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    var backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            backgroundColor
                .clipShape(Circle())
            
            configuration.label
                .bold()
        }
        .aspectRatio(1.0, contentMode: .fit)
        .opacity(isEnabled ? 1 : 0.5)
        .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

struct CircleButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Image(systemName: "checkmark")
        }
        .buttonStyle(CircleButtonStyle(backgroundColor: .accentColor))
        .previewLayout(.sizeThatFits)
    }
}
