//
//  Created on 24.03.2023.
//

import Foundation
import SwiftUI

extension MainScreen {
    @MainActor
    final class ViewModel: ObservableObject {
        
        @Published private(set) var welcomeMessage: String = ""
        @Published private(set) var selectedRelativeDate: String = ""
        @Published private(set) var selectedFormattedDate: String = ""
        @Published private(set) var completedTaskPercentage: String?
        
        @Published private(set) var taskCards: [TaskCard] = []
        
        var tasksNumber: Int {
            taskCards.count
        }
        
        var boardsNumber: Int {
            boards.count
        }
        
        private var tasks: [Todo.Task] = []
        private var boards: [Board] = []
        
        private let tasksRepository: ITasksRepository
        private let boardsRepository: IBoardsRepository
        private let tagColorProvider: ITagColorProvider
        private let dateGenerator: DateGenerator
        
        private let createTaskButtonTapped: VoidCallback
        private let taskTapped: (Int) -> Void
        
        private var cancelBag: Set<Task<(), Never>> = []
        
        private var dateFormatter: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .medium
            
            return dateFormatter
        }
        
        private var percentageFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            
            return formatter
        }
        
        private var remainingTimeFormatter: DateComponentsFormatter {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.zeroFormattingBehavior = .pad
            formatter.allowedUnits = [.hour, .minute]
            
            return formatter
        }
        
        nonisolated init(
            tasksRepository: ITasksRepository,
            boardsRepository: IBoardsRepository,
            tagColorProvider: ITagColorProvider,
            dateGenerator: @escaping DateGenerator = Date.init,
            createTaskButtonTapped: @escaping VoidCallback,
            taskTapped: @escaping (Int) -> Void
        ) {
            self.tasksRepository = tasksRepository
            self.boardsRepository = boardsRepository
            self.tagColorProvider = tagColorProvider
            self.dateGenerator = dateGenerator
            self.createTaskButtonTapped = createTaskButtonTapped
            self.taskTapped = taskTapped
            
            Task {
                await subscribeToRepositoriesEvents()
            }
        }
        
        deinit {
            cancelBag.forEach { task in
                task.cancel()
            }
            cancelBag.removeAll()
        }
        
        func load() async {
            welcomeMessage = R.string.localizable.main_welcome_good_morning()
            
            let relativeWeekDayFormatter = RelativeWeekDayFormatter(todayGenerator: dateGenerator)
            selectedRelativeDate = relativeWeekDayFormatter.string(from: dateGenerator()) ?? ""
            selectedFormattedDate = dateFormatter.string(from: dateGenerator())
            
            await loadTasks()
            await loadBoards()
        }
        
        func createTask() {
            createTaskButtonTapped()
        }
        
        func taskCardTapped(taskId: Int) {
            taskTapped(taskId)
        }
        
        private func subscribeToRepositoriesEvents() {
            let taskEventsTask = Task { [weak self] in
                guard let self = self else { return }
                
                for await event in self.tasksRepository.eventPublisher.values {
                    self.handleTaskEvent(event)
                }
            }
            cancelBag.insert(taskEventsTask)
        }
        
        private func handleTaskEvent(_ event: TaskRepositoryEvent) {
            switch event {
            case .added(let task):
                tasks.insert(task, at: 0)
                updateTaskCards(withTasks: tasks)
            }
        }
        
        private func loadTasks() async {
            tasks = await tasksRepository.getAll()
            updateTaskCards(withTasks: tasks)
        }
        
        private func loadBoards() async {
            boards = await boardsRepository.getAll()
        }
        
        private func updateTaskCards(withTasks tasks: [Todo.Task]) {
            taskCards = tasks.enumerated().map { index, task in
                mapTaskToCard(task, withColor: tagColorProvider.tagColorFor(index: index))
            }
            
            updatePercentage(withTasks: tasks)
        }
        
        private func updatePercentage(withTasks tasks: [Todo.Task]) {
            guard !tasks.isEmpty else { return }
            
            let completedTasks = tasks.filter({ $0.completed })
            let completedTasksRatio = Float(completedTasks.count) / Float(tasks.count)
            let percentage = percentageFormatter.string(from: NSNumber(value: completedTasksRatio)) ?? ""
            completedTaskPercentage = R.string.localizable.main_completed_tasks_percentage(percentage)
        }
        
        private func mapTaskToCard(_ task: Todo.Task, withColor color: Color) -> TaskCard {
            let remainingTime = task.deadline == nil
            ? nil
            : remainingTimeFormatter.string(from: task.deadline!.timeIntervalSince(dateGenerator()))
            
            return TaskCard(
                id: task.id,
                name: task.name,
                boardName: task.board.name,
                remainingTime: remainingTime,
                completed: task.completed,
                tagColor: color
            )
        }
    }
}
