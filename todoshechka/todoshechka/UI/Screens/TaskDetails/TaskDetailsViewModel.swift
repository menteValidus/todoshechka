//
//  Created on 19.04.23.
//

import Foundation

extension TaskDetails {
    final class ViewModel: ObservableObject {
        @Published var taskName: String = ""
        @Published var taskDescription: String = ""
        @Published private(set) var deadlineModel: DeadlinePicker.Model?
        
        private let tasksRepository: ITasksRepository
        private let taskId: Int
        
        private lazy var deadlineMapper = DateToDeadlineModelMapper()
        
        init(tasksRepository: ITasksRepository, taskId: Int) {
            self.tasksRepository = tasksRepository
            self.taskId = taskId
        }
        
        func start() {
            loadTask()
        }
        
        func updateTask(name: String, description: String, deadlineModel: DeadlinePicker.Model?) {
            taskName = name
            taskDescription = description
            self.deadlineModel = deadlineModel
        }
        
        private func loadTask() {
            Task { [weak self] in
                guard let self = self else { return }
                
                let task = await self.tasksRepository.get(byId: self.taskId)
                self.taskName = task.name
                self.taskDescription = task.description
                if let deadline = task.deadline {
                    self.deadlineModel = deadlineMapper.map(deadline)
                }
            }
        }
    }
}
