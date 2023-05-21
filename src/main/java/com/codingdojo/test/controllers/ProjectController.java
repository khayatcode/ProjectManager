package com.codingdojo.test.controllers;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codingdojo.test.models.Project;
import com.codingdojo.test.models.Task;
import com.codingdojo.test.models.User;
import com.codingdojo.test.services.ProjectService;
import com.codingdojo.test.services.TaskService;
import com.codingdojo.test.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/project")
public class ProjectController {
	
    @Autowired
    private ProjectService projectService;

    @Autowired
    private UserService userService;

    @Autowired
    private TaskService taskService;

    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
			return "redirect:/";
		}
        
    	User thisUser = userService.getById((Long) session.getAttribute("userID"));
		model.addAttribute("user", thisUser);
        // get projects where user is not a part off
        model.addAttribute("projects", projectService.findProjectsNotUser(thisUser));
        return "allProject.jsp";
    }

    @GetMapping("/new")
    public String newProject(@ModelAttribute("project") Project project, HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
			return "redirect:/";
		}
        User thisUser = userService.getById((Long) session.getAttribute("userID"));
        model.addAttribute("user", thisUser);
        return "createProject.jsp";
    }

    @PostMapping("/new/create")
    public String createProject(@Valid @ModelAttribute("project") Project project, BindingResult result, HttpSession session, Model model) {
    	User thisUser = userService.getById((Long) session.getAttribute("userID"));
    	var currentDate = new Date();
        if (result.hasErrors()) {
            model.addAttribute("user", thisUser);
            model.addAttribute("dateError", "");
            model.addAttribute("bindingResult", result);
            return "createProject.jsp";
        } else if (project.getDueDate().before(currentDate)) {
            Boolean dateError = true;
            model.addAttribute("dateError", dateError);
        	model.addAttribute("dateErrorMessage", "Due date must be in the future.");
        	model.addAttribute("user", thisUser);
            model.addAttribute("bindingResult", result);
            return "createProject.jsp";
        }
        else {
            project.setOwner(thisUser);          
            if (project.getUsers() == null) {
                project.setUsers(new ArrayList<>());
            }
            if (project.getTasks() == null) {
                project.setTasks(new ArrayList<>());
            }
            project.getUsers().add(thisUser);
            projectService.createOrUpdate(project);
            System.out.println(project.getUsers());
            return "redirect:/project/show/yourProject/" + thisUser.getId();
            }
        }

    @PostMapping("/join/{id}")
    public String joinProject(@PathVariable("id") Long projectId, HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/";
        }
        User thisUser = userService.getById((Long) session.getAttribute("userID"));
        model.addAttribute("user", thisUser);
        userService.addUserToProject(thisUser.getId(),projectId);
        return "redirect:/project/show/yourProject/" + thisUser.getId();
    }

    @GetMapping("/show/yourProject/{id}")
    public String showYourProject(HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/";
        }
        User thisUser = userService.getById((Long) session.getAttribute("userID"));
        model.addAttribute("user", thisUser);
        model.addAttribute("projects", projectService.findProjectsByUser(thisUser));
        return "yourProject.jsp";
    }

    @PostMapping("/leave/{id}")
    public String leaveProject(@PathVariable("id") Long projectId, HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/";
        }
        User thisUser = userService.getById((Long) session.getAttribute("userID"));
        model.addAttribute("user", thisUser);
        userService.removeUserFromProject(thisUser.getId(), projectId);
        return "redirect:/project/show/yourProject/" + thisUser.getId();
    }

    @GetMapping("/show/{id}")
    public String showProject(@PathVariable("id") Long projectId, HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/";
        }
        User thisUser = userService.getById((Long) session.getAttribute("userID"));
        model.addAttribute("user", thisUser);
        model.addAttribute("project", projectService.findProjectById(projectId));
        return "viewProject.jsp";
    }

    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable("id") Long projectId, @ModelAttribute("project") Project project  ,HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/";
        }
        User thisUser = userService.getById((Long) session.getAttribute("userID"));
        model.addAttribute("user", thisUser);
        model.addAttribute("project", projectService.findProjectById(projectId));
        return "editProject.jsp";
    }

    @PutMapping("/edit/{id}")
    public String editProject(@PathVariable("id") Long projectId, @Valid @ModelAttribute("project") Project project, BindingResult result, HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/";
        }
        User thisUser = userService.getById((Long) session.getAttribute("userID"));
        var currentDate = new Date();
        if (result.hasErrors()) {
        	boolean dateError = false;
        	for (ObjectError error : result.getAllErrors()) {
                System.out.println(error.getDefaultMessage());
            }
        	model.addAttribute("dateError", dateError);
            model.addAttribute("user", thisUser);
            model.addAttribute("bindingResult", result);
            System.out.println("First error");
            return "editProject.jsp";
        } else if (project.getDueDate().before(currentDate)) {
            Boolean dateError = true;
            model.addAttribute("dateError", dateError);
        	model.addAttribute("dateErrorMessage", "Due date must be in the future.");
        	model.addAttribute("user", thisUser);
            model.addAttribute("bindingResult", result);
            System.out.println("second error");
            return "editProject.jsp";
        }
        else {
            project.setOwner(thisUser);
            projectService.createOrUpdate(project);
            userService.addUserToProject(thisUser.getId(), projectId);
            return "redirect:/project/show/" + projectId;
        }
    }

    @GetMapping("/tasks/{id}")
    public String showTasks(@PathVariable("id") Long projectId, @ModelAttribute("task") Task task, HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/";
        }
        User thisUser = userService.getById((Long) session.getAttribute("userID"));
        model.addAttribute("user", thisUser);
        model.addAttribute("project", projectService.findProjectById(projectId));
        return "taskProject.jsp";
    }

    @PostMapping("/create/tasks/{id}")
    public String createTask(@PathVariable("id") Long projectId, @Valid @ModelAttribute("task") Task task, BindingResult result, HttpSession session, Model model) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/";
        }
        User thisUser = userService.getById((Long) session.getAttribute("userID"));
        if (result.hasErrors()) {
            model.addAttribute("user", thisUser);
            model.addAttribute("project", projectService.findProjectById(projectId));
            model.addAttribute("bindingResult", result);
            return "taskProject.jsp";
        } else {
        	task.setUser(thisUser);
            task.setProject(projectService.findProjectById(projectId));
            taskService.createOrUpdate(task);
            return "redirect:/project/tasks/" + projectId;
        }
    }

    @DeleteMapping("/delete/{id}")
    public String deleteProject(@PathVariable("id") Long projectId, HttpSession session) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/";
        }
        projectService.deleteProject(projectId);
        return "redirect:/project/show/yourProject/" + projectId;
    }
    
    
    
    



	

}
