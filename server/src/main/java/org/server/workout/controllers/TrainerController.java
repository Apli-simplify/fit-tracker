package org.server.workout.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
@RestController
@RequestMapping("/api/trainer")
public class TrainerController {
    @GetMapping("/dashboard")
    public ResponseEntity<String> getTrainerDashboard() {
        System.out.println("trainer Dashboard accessed.");
        return ResponseEntity.ok("trainer Dashboard");
    }
}
