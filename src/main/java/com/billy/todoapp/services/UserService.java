package com.billy.todoapp.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.billy.todoapp.models.LoginUser;
import com.billy.todoapp.models.User;
import com.billy.todoapp.repostiories.UserRepository;

@Service
public class UserService {
	
	private final UserRepository userRepo;

	public UserService(UserRepository userRepo) {
		this.userRepo = userRepo;
	}
	
        
	public User register(User newUser, BindingResult result) {
		Optional<User> optionalUser = userRepo.findByEmail(newUser.getEmail());
	
	    
		
//		if the email is present then do this 
		if(optionalUser.isPresent()) {
			result.rejectValue("email","unique","this email is already Registered");
		}
//		if the password doesn't match 
		if(!newUser.getPassword().equals(newUser.getConfirm())) {
			result.rejectValue("confirm","match","password doesnt match");
		}
		
//		if the result had errors 
		if(result.hasErrors()){
			return null;
		}
		
//		hashed set password
		String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
		newUser.setPassword(hashed);
		return userRepo.save(newUser);
		
	}

	
		
	
//	process loginFrom
	public User login(LoginUser newLogin, BindingResult result) {
	    Optional<User> potentialUser = userRepo.findByEmail(newLogin.getEmail());
	    if (!potentialUser.isPresent()) {
	        result.rejectValue("email", "unique", "This email is not registered.");
	        return null;
	    }
	    
	    User loggedUser = potentialUser.get();
	    if (!BCrypt.checkpw(newLogin.getPassword(), loggedUser.getPassword())) {
	        result.rejectValue("password", "matches", "Invalid password.");
	        return null;
	    }
	    
	    return loggedUser;
	}
	
	 // Method to retrieve a user by ID
    public User getUserById(Long userId) {
        Optional<User> userOptional = userRepo.findById(userId);
        return userOptional.orElse(null); // Return the user if found, otherwise return null
    }
}