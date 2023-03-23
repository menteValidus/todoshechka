//
//  Created on 22.03.2023.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        VStack {
            topView
            welcomeMessage
                .padding(.bottom)
            summary
            StyledPicker()
                .padding(.top)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("colors/primary")
        )
    }
}

extension MainScreen {
    var topView: some View {
        HStack {
            Color("colors/onPrimaryVariant2")
                .frame(width: 38, height: 38)
                .mask(Circle())
            Spacer()
            
        }
    }
    
    var welcomeMessage: some View {
        Text("Good Morning")
            .foregroundColor(Color("colors/onPrimaryVariant1"))
            .font(.system(size: 74))
            .lineSpacing(0)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var summary: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Today's Monday")
                    .foregroundColor(Color("colors/onPrimaryVariant3"))
                    .font(.body)
                Text("Dec 12, 2022")
                    .foregroundColor(Color("colors/onPrimaryVariant4"))
                    .font(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("75% Done")
                    .foregroundColor(Color("colors/onPrimaryVariant3"))
                    .font(.body)
                Text("Completed Tasks")
                    .foregroundColor(Color("colors/onPrimaryVariant4"))
                    .font(.caption)
            }
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
