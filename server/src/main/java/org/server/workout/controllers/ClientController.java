package org.server.workout.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/client")
public class ClientController {
    @GetMapping("/dashboard")
    public ResponseEntity<String> getClientDashboard() {
        System.out.println("client Dashboard accessed.");
        return ResponseEntity.ok("client Dashboard");
    }
}
