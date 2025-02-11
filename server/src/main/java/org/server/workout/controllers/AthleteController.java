package org.server.workout.controllers;

import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.AthleteDto;
import org.server.workout.dto.UserDto;
import org.server.workout.exceptions.specifics.ResourceAlreadyExistException;
import org.server.workout.exceptions.specifics.ResourceNotFoundException;
import org.server.workout.service.interfaces.AthleteService;
import org.server.workout.service.interfaces.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
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
            AuthenticationResponse authenticationResponse = athleteService.registerAthlete(athleteDto);
            if(authenticationResponse != null) {
                return ResponseEntity.status(201).body(Map.of("message", "athlete registered successfully"));
            }
            throw new ResourceAlreadyExistException("Athlete already exist");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "message", "Error during registration",
                    "error", e.getMessage()
            ));
        }
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateAthlete(@PathVariable Long id, @RequestBody AthleteDto athleteDto) {
        try {
            athleteService.updateAthlete(id, athleteDto);
            return ResponseEntity.ok(Map.of("message", "Athlete updated successfully"));
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.status(404).body(Map.of(
                    "message", "Athlete not found",
                    "error", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "message", "Error during update",
                    "error", e.getMessage()
            ));
        }
    }
}
