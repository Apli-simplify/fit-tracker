package org.server.workout.controllers;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.UserDto;
import org.server.workout.entities.User;
import org.server.workout.exceptions.specifics.ResourceAlreadyExistException;
import org.server.workout.service.interfaces.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping
    public ResponseEntity<?> protectedResource() {
        System.out.println("Accessing protected resource");
        return ResponseEntity.ok("This is a protected resource");
    }

    @GetMapping("/user-info")
    public ResponseEntity<?> userInfos() {
            System.out.println("user info");
            String email = SecurityContextHolder.getContext().getAuthentication().getName();

            return ResponseEntity.status(200).body(userService.findByEmail(email));
    }

    @PostMapping("/signup")
    public ResponseEntity<?> register(@RequestBody UserDto userDto) {
        try {
            if(userService.register(userDto) != null) {
                return ResponseEntity.status(201).body(Map.of("message", "User registered successfully"));
            }
            throw new ResourceAlreadyExistException("User already exist");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "message", "Error during registration",
                    "error", e.getMessage()
            ));
        }
    }
    // the signin normally spring security handles the exception if the user gets wrong the username and password
    // but if you kept it he will expose the api in error so returning a response of e.getMessage() is better
    @PostMapping("/signin")
    public ResponseEntity<?> login(@RequestBody UserDto userDto) {
        try {

            AuthenticationResponse authenticationResponse = userService.login(userDto);
            return ResponseEntity.status(200).body(authenticationResponse);
        } catch (Exception e) {
            return ResponseEntity.status(401).body(e.getMessage());
        }
    }

}
