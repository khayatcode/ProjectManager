package com.codingdojo.test.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.codingdojo.test.models.LoginUser;
import com.codingdojo.test.models.User;
import com.codingdojo.test.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userServ;

	@GetMapping("/")
	public String index(Model model, @ModelAttribute("newUser") User newUser,
			@ModelAttribute("newLogin") LoginUser newLogin) {
		return "login.jsp";
	}


	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {

		// TO-DO Later -- call a register method in the service
		User thisUser = this.userServ.register(newUser, result);
		if (result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			model.addAttribute("regBindingResult", result);
			return "login.jsp";
		}

		// TO-DO Later: Store their ID from the DB in session, and redirect
		session.setAttribute("userID", thisUser.getId());

		return "redirect:/project/home";
	}

	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {

		User thisUser = userServ.login(newLogin, result);

		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			model.addAttribute("logBindingResult", result);
			return "login.jsp";
		}

		// TO-DO Later: Store their ID from the DB in session, and redirect
		session.setAttribute("userID", thisUser.getId());

		return "redirect:/project/home";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

}
