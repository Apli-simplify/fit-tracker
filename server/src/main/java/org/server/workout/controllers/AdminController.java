
package org.server.workout.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin")
public class AdminController {
    @GetMapping("/dashboard")
    public ResponseEntity<String> getAdminDashboard() {
        System.out.println("Admin Dashboard accessed.");
        return ResponseEntity.ok("Admin Dashboard");
    }
}
