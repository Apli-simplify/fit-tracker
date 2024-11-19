package org.server.workout.controllers;

import org.server.workout.dto.UserDto;
import org.server.workout.service.interfaces.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/athlete")
public class AthleteController {
    @Autowired
    UserService userService;
    @GetMapping("/dashboard")
    public ResponseEntity<String> getAthleteDashboard() {
        System.out.println("athlete Dashboard accessed.");
        return ResponseEntity.ok("athlete Dashboard");
    }

    @PostMapping("/signup")
    public ResponseEntity<?> register(@RequestBody UserDto userDto) {
            return ResponseEntity.status(201).body("Athlete registered successfully");
    }
}
