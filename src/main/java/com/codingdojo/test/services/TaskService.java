package com.codingdojo.test.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.test.models.Task;
import com.codingdojo.test.repositories.TaskRepository;

@Service
public class TaskService {

    @Autowired
    private TaskRepository taskRepo;

    // Create
    public Task createOrUpdate(Task newTask) {
        return taskRepo.save(newTask);
    }

    // All Tasks
    public List<Task> allTasks() {
        return taskRepo.findAll();
    }

    // Find By ID
    public Task getById(Long id) {
        return this.taskRepo.findById(id).orElse(null);
    }

    // Delete
    public void deleteTask(Long id) {
        taskRepo.deleteById(id);
    }
	

}
