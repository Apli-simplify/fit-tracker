package org.server.workout.controllers;

import org.server.workout.dto.AthleteDto;
import org.server.workout.dto.UserDto;
import org.server.workout.service.interfaces.AthleteService;
import org.server.workout.service.interfaces.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/athlete")
public class AthleteController {
    @Autowired
    AthleteService athleteService;
    @GetMapping("/dashboard")
    public ResponseEntity<String> getAthleteDashboard() {
        System.out.println("athlete Dashboard accessed.");
        return ResponseEntity.ok("athlete Dashboard");
    }

    @PostMapping("/signup")
    public ResponseEntity<?> register(@RequestBody AthleteDto athleteDto) {
        try {
            System.out.println("coming dto : " + athleteDto);
            athleteService.registerAthlete(athleteDto);
            return ResponseEntity.status(201).body(Map.of("message", "athlete registered successfully"));
        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "message", "Error during registration",
                    "error", e.getMessage()
            ));
        }
    }
}
