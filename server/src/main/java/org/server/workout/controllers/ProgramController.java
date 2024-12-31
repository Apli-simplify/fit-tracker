package org.server.workout.controllers;

import jakarta.servlet.http.HttpServletRequest;
import org.server.workout.dto.CustomProgramDto;
import org.server.workout.entities.*;
import org.server.workout.exceptions.specifics.ResourceAlreadyExistException;
import org.server.workout.exceptions.specifics.ResourceNotFoundException;
import org.server.workout.helpers.JwtUtil;
import org.server.workout.repositories.ExerciseRepository;
import org.server.workout.repositories.ProgramRepository;
import org.server.workout.repositories.UserRepository;
import org.server.workout.service.interfaces.ProgramService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/programs")
public class ProgramController {
    @Autowired
    ExerciseRepository exerciseRepository;
    @Autowired
    private ProgramService programService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ProgramRepository programRepository;
    @Autowired
    JwtUtil jwtUtil;
    @GetMapping
    public ResponseEntity<List<Program>> getAllPrograms() {
        Optional<List<Program>> programs = programService.GetPrograms();

        if (programs.isEmpty() || programs.get().isEmpty()) {
            throw new ResourceNotFoundException("Programs not found");
        }
        return ResponseEntity.ok(programs.get());
    }

    @PostMapping("/save")
    public ResponseEntity<?> saveCustomProgram(@RequestBody CustomProgramDto customProgramDto, HttpServletRequest request) {
        String authorizationHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authorization token is missing or invalid.");
        }

        String token = authorizationHeader.substring(7);
        Long athleteId = jwtUtil.extractId(token);
        System.out.println("The ID is: " + athleteId);

        if (customProgramDto == null) {
            return ResponseEntity.badRequest().body("Custom program data is required.");
        }

        // Check if the athlete exists
        Optional<User> athleteOpt = userRepository.findById(athleteId);
        if (athleteOpt.isEmpty()) {
            return ResponseEntity.badRequest().body("Athlete not found.");
        }

        Athlete athlete = (Athlete) athleteOpt.get();

        // Handle exercises
        Set<Exercise> exercises = new HashSet<>();
        for (Exercise exercise : customProgramDto.getExercises()) {
            if (exercise.getId() != null) {
                // Fetch the exercise from the database if it has an ID
                Optional<Exercise> existingExercise = exerciseRepository.findById(exercise.getId());
                existingExercise.ifPresent(exercises::add);
            } else {
                // Save new exercises
                Exercise savedExercise = exerciseRepository.save(exercise);
                exercises.add(savedExercise);
            }
        }

        // Create the Customprogram entity
        Customprogram customProgram = new Customprogram();
        customProgram.setName(customProgramDto.getName());
        customProgram.setImage(customProgramDto.getImage());
        customProgram.setStatus(customProgramDto.getStatus());
        customProgram.setExercises(exercises);
        customProgram.setAthlete(athlete);

        // Save the Customprogram entity
        Program savedProgram = programRepository.save(customProgram);

        return ResponseEntity.status(HttpStatus.CREATED).body(savedProgram);
    }

    @GetMapping("/customs")
    public ResponseEntity<List<Program>> getAllProgramsCustoms() {
        Optional<List<Program>> programs = programService.GetProgramsCustoms();

        if (programs.isEmpty() || programs.get().isEmpty()) {
            throw new ResourceNotFoundException("Programs not found");
        }
        return ResponseEntity.ok(programs.get());
    }
}