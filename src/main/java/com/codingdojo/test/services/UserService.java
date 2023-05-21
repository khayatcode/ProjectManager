package com.codingdojo.test.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.test.models.LoginUser;
import com.codingdojo.test.models.Project;
import com.codingdojo.test.models.Task;
import com.codingdojo.test.models.User;
import com.codingdojo.test.repositories.ProjectRepository;
import com.codingdojo.test.repositories.TaskRepository;
import com.codingdojo.test.repositories.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private ProjectRepository projectRepo;
	
	@Autowired
	private TaskRepository taskRepo;

	// Create
	public User createOrUpdate(User newUser) {
		return userRepo.save(newUser);
	}

	// All Users
	public List<User> allUsers() {
		return userRepo.findAll();
	}

	// Find By ID
	public User getById(Long id) {
		return this.userRepo.findById(id).orElse(null);
	}
	
	// Add user to Project 
	public void addUserToProject(Long user_id, Long project_id) {
		User user = userRepo.findById(user_id).orElse(null);
		Project project = projectRepo.findById(project_id).orElse(null);
		if(user != null && project != null) {
			project.getUsers().add(user);
			projectRepo.save(project);
		} else {
			System.out.println("Did not add user");
		}
	}
	
	// remove user from project
	public void removeUserFromProject(Long userId, Long projectId) {
		User user = userRepo.findById(userId).orElse(null);
		Project project = projectRepo.findById(projectId).orElse(null);
		
		if(user != null && project != null) {
			user.getProjects().remove(project);
			userRepo.save(user);
		}
	}
	
	// add task to User
	public void addTaskToUser(Long taskId, Long userId) {
		User user = userRepo.findById(userId).orElse(null);
		Task task = taskRepo.findById(taskId).orElse(null);
		
		if(user != null && task != null) {
			task.setUser(user);
			taskRepo.save(task);
		}
	}
	
	
	// Register
		public User register(User newUser, BindingResult result) {

			// Check if a user with the same email already exists in the database
			Optional<User> potentialUser = userRepo.findByEmail(newUser.getEmail());

			// If a user with the same email exists, add an error message to the
			// BindingResult
			if (potentialUser.isPresent()) {
				result.rejectValue("email", "Matches", "Email already exists!");
			}

			// Check if the password and confirm fields match
			if (!newUser.getPassword().equals(newUser.getConfirm())) {
				result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
			}

			// If there are any errors in the BindingResult, return null
			if (result.hasErrors()) {
				return null;
			}

			// Hash the user's password using the BCrypt algorithm
			String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashed);

			// Create a new user or update an existing user in the database
			return this.createOrUpdate(newUser);
		}

		
		public User login(LoginUser newLogin, BindingResult result) {

			// Find user in the DB by email
			Optional<User> potentialUser = userRepo.findByEmail(newLogin.getEmail());

			// If user not found, add error message to the BindingResult and return null
			if (!potentialUser.isPresent()) {
				result.rejectValue("email", "Matches", "Invalid Email/Password!");
				return null;
			}

			// Get the user object from the Optional
			User thisUser = potentialUser.get();

			// Check if the password provided matches the hashed password in the database
			if (!BCrypt.checkpw(newLogin.getPassword(), thisUser.getPassword())) {
				result.rejectValue("password", "Matches", "Invalid Email/Password!");
			}

			// If there are any errors in the BindingResult, return null
			if (result.hasErrors()) {
				return null;
			}

			// If everything checks out, return the User object
			return thisUser;
		}

}
