package org.server.workout.controllers;

import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.UserDto;
import org.server.workout.service.interfaces.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    // A protected resource that requires authentication
    @GetMapping
    public ResponseEntity<?> protectedResource() {
        System.out.println("Accessing protected resource");
        return ResponseEntity.ok("This is a protected resource");
    }

    // Register a new user
    @PostMapping("/signup")
    public ResponseEntity<?> register(@RequestBody UserDto userDto) {
        try {
            userService.register(userDto);
            return ResponseEntity.status(201).body("User registered successfully");
        } catch (Exception e) {
            // Handle registration failure (e.g., user already exists)
            return ResponseEntity.status(400).body("Error during registration: " + e.getMessage());
        }
    }
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody UserDto userDto) {
        try {
            System.out.println("yes + " + userDto);

            // Call the login service
            AuthenticationResponse authenticationResponse = userService.login(userDto);
            System.out.println("yes");
            // Return successful login response with JWT tokens
            return ResponseEntity.status(200).body(authenticationResponse); // 200 OK with tokens
        } catch (Exception e) {
            // Handle login failure
            return ResponseEntity.status(401).body("Invalid credentials: " + e.getMessage()); // 401 Unauthorized
        }
    }

}
