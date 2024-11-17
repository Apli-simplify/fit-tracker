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
            return ResponseEntity.status(400).body("Error during registration: " + e.getMessage());
        }
    }
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody UserDto userDto) {
        try {
            System.out.println("yes + " + userDto);

            AuthenticationResponse authenticationResponse = userService.login(userDto);
            System.out.println("yes");
            return ResponseEntity.status(200).body(authenticationResponse);
        } catch (Exception e) {
            // Handle login failure
            return ResponseEntity.status(401).body("Invalid credentials: " + e.getMessage());
        }
    }

}
