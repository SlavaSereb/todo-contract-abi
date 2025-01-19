// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    struct Task {
        uint256 id;
        string description;
        bool completed;
    }

    event TaskAdded(uint256 id, string description);
    event TaskCompleted(uint256 id);

    mapping(uint256 => Task) private tasks;
    uint256 private nextTaskId;

    // Add a new task
    function addTask(string memory _description) external {
        require(bytes(_description).length > 0, "Description cannot be empty");

        tasks[nextTaskId] = Task({
            id: nextTaskId,
            description: _description,
            completed: false
        });

        emit TaskAdded(nextTaskId, _description);
        nextTaskId++;
    }

    // Mark a task as completed
    function completeTask(uint256 _taskId) external {
        require(_taskId < nextTaskId, "Task does not exist");
        Task storage task = tasks[_taskId];
        require(!task.completed, "Task is already completed");

        task.completed = true;

        emit TaskCompleted(_taskId);
    }

    // Get all tasks
    function getTasks() external view returns (Task[] memory) {
        Task[] memory taskList = new Task[](nextTaskId);

        for (uint256 i = 0; i < nextTaskId; i++) {
            taskList[i] = tasks[i];
        }

        return taskList;
    }
}
