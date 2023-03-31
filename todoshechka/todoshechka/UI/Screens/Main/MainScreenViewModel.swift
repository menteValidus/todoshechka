//
//  Created on 24.03.2023.
//

import Foundation

extension MainScreen {
    @MainActor
    final class ViewModel: ObservableObject {
        
        @Published private(set) var welcomeMessage: String = ""
        @Published private(set) var selectedRelativeDate: String = ""
        @Published private(set) var selectedFormattedDate: String = ""
        
        @Published private(set) var taskCards: [TaskCard] = []
        
        private var tasks: [Todo.Task] = []
        private var boards: [Board] = []
        
        private let dateGenerator: DateGenerator
        
        private let createTaskButtonTapped: VoidCallback
        
        private var dateFormatter: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .medium
            
            return dateFormatter
        }
        
        nonisolated init(
            dateGenerator: @escaping DateGenerator = Date.init,
            createTaskButtonTapped: @escaping VoidCallback
        ) {
            self.dateGenerator = dateGenerator
            self.createTaskButtonTapped = createTaskButtonTapped
        }
        
        func load() {
            welcomeMessage = R.string.localizable.welcome_good_morning()
            
            let relativeWeekDayFormatter = RelativeWeekDayFormatter(todayGenerator: dateGenerator)
            selectedRelativeDate = relativeWeekDayFormatter.string(from: dateGenerator()) ?? ""
            selectedFormattedDate = dateFormatter.string(from: dateGenerator())
            
            loadTasks()
        }
        
        func createTask() {
            createTaskButtonTapped()
        }
        
        private func loadTasks() {
            tasks = [
                .init(id: 1, name: "Task 1", board: Board(id: 1, name: "Myself"), deadline: Date()),
                .init(id: 2, name: "Task 2", board: Board(id: 2, name: "Myself"), deadline: Date()),
                .init(id: 3, name: "Task 3", board: Board(id: 3, name: "Myself"), deadline: Date())
            ]
            
            taskCards = tasks.map { task in
                mapTaskToCard(task)
            }
        }
        
        private func mapTaskToCard(_ task: Todo.Task) -> TaskCard {
            TaskCard(
                id: task.id,
                name: task.name,
                boardName: task.board.name,
                remainingTime: "todo",
                completed: task.completed,
                tagColor: R.color.tags.accent1.color
            )
        }
    }
}
