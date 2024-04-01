package com.billy.todoapp.controllers;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.billy.todoapp.models.LoginUser;
import com.billy.todoapp.models.User;
import com.billy.todoapp.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {
	
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/")
    public String renderLogReg(Model model,HttpSession session) {
    	if (session.getAttribute("userId") != null) {
            return "redirect:/home"; // Redirect authenticated users to the home page
    	}
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "logreg.jsp";
    }
    @PostMapping("/register")
    public String processRegister(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {
        User registeredUser = userService.register(newUser, result);
        if (registeredUser == null) {
            // If registration fails due to validation errors or other reasons
            model.addAttribute("newLogin", new LoginUser());
            return "logreg.jsp";
        } else {
            session.setAttribute("userId", registeredUser.getId());
            session.setAttribute("userName", registeredUser.getUserName());
            return "redirect:/home";
        }
    }


    @PostMapping("/login")
    public String processLogin(@Valid @ModelAttribute("newLogin") LoginUser newLoginUser, BindingResult result, Model model, HttpSession session) {
        User loggedUser = userService.login(newLoginUser, result);
        if (loggedUser == null) {
            model.addAttribute("newLogin", newLoginUser); 
            model.addAttribute("newUser", new User());
            return "logreg.jsp";
        } else {
            session.setAttribute("userId", loggedUser.getId());
            session.setAttribute("userName", loggedUser.getUserName());
            return "redirect:/home"; 
        }
    }

    

    @GetMapping("/logout")
    public String processLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/"; // Change to the appropriate route

    }
   
	
}

