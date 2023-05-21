package com.codingdojo.test.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.test.models.Project;
import com.codingdojo.test.models.Task;
import com.codingdojo.test.models.User;
import com.codingdojo.test.repositories.ProjectRepository;
import com.codingdojo.test.repositories.TaskRepository;

@Service
public class ProjectService {
	
	@Autowired
	private ProjectRepository projectRepo;
	
	@Autowired
	private TaskRepository taskRepo;

	// create or update a project
	public Project createOrUpdate(Project project) {
		return projectRepo.save(project);
	}

	// find a project by id
	public Project findProjectById(Long id) {
		return projectRepo.findById(id).orElse(null);
	}

	// find all projects
	public List<Project> findAllProjects() {
		return projectRepo.findAll();
	}

	// delete a project
	public void deleteProject(Long id) {
		projectRepo.deleteById(id);
	}

	// List of projects that a user is part of
	public List<Project> findProjectsByUser(User user) {
		return projectRepo.findAllByUsers(user);
	}

	// List of projects that a user is not part of
	public List<Project> findProjectsNotUser(User user) {
		return projectRepo.findByUsersNotContains(user);
	}
	
	// add Task to Project
	public void addTaskToProject(Long taskId, Long projectId) {
		Project project = projectRepo.findById(projectId).orElse(null);
		Task task = taskRepo.findById(taskId).orElse(null);
		
		if(project != null && task != null) {
			task.setProject(project);
			taskRepo.save(task);
		}
	}

}
