//
//  Created on 22.03.2023.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack {
                    topView
                    welcomeMessage
                        .padding(.bottom)
                    summary
                    StyledPicker()
                        .padding(.top)
                    taskCards
                        .padding(.top)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .background(R.color.primary.color)
            
            fab
        }
        .onAppear {
            viewModel.start()
        }
    }
}

extension MainScreen {
    var topView: some View {
        HStack {
            R.color.onPrimaryVariant2.color
                .frame(width: 38, height: 38)
                .mask(Circle())
            Spacer()
            
        }
    }
    
    var welcomeMessage: some View {
        Text(viewModel.welcomeMessage)
            .foregroundColor(R.color.onPrimaryVariant1.color)
            .font(.system(size: 74))
            .lineSpacing(0)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var summary: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.selectedRelativeDate)
                    .foregroundColor(R.color.onPrimaryVariant3.color)
                    .font(.body)
                Text(viewModel.selectedFormattedDate)
                    .foregroundColor(R.color.onPrimaryVariant4.color)
                    .font(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("75% Done")
                    .foregroundColor(R.color.onPrimaryVariant3.color)
                    .font(.body)
                Text("Completed Tasks")
                    .foregroundColor(R.color.onPrimaryVariant4.color)
                    .font(.caption)
            }
        }
    }
    
    var taskCards: some View {
        LazyVStack(spacing: 0) {
            Card(taskName: "Task 1", boardName: "Myself", timeLeftText: "1h 30m", completed: false, backgroundColor: R.color.tags.accent1.color, onComplete: {})
            
            Card(taskName: "Task 1", boardName: "Myself", timeLeftText: "1h 30m", completed: false, backgroundColor: R.color.tags.accent2.color, onComplete: {})
            
            Card(taskName: "Task 1", boardName: "Myself", timeLeftText: "1h 30m", completed: false, backgroundColor: R.color.tags.accent3.color, onComplete: {})
        }
    }
    
    var fab: some View {
        Button(action: {}) {
            ZStack {
                R.color.secondary1.color
                    .clipShape(Circle())
                
                Image(systemName: "plus")
                    .bold()
                    .foregroundColor(R.color.onSecondary1.color)
            }
        }
        .frame(width: 80, height: 80)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(viewModel: MainScreenViewModel())
            .preferredColorScheme(.dark)
    }
}
