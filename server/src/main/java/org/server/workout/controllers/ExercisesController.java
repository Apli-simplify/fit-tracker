package org.server.workout.controllers;

import org.server.workout.entities.Exercise;
import org.server.workout.exceptions.specifics.ResourceNotFoundException;
import org.server.workout.repositories.ExerciseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/exercises")
public class ExercisesController {
    @Autowired
    ExerciseRepository exerciseRepository;
    @GetMapping
    public ResponseEntity<List<Exercise>> getAllExercises() {
        Optional<List<Exercise>> exercises = Optional.of(exerciseRepository.findAll());

        if (exercises.get().isEmpty()) {
            throw new ResourceNotFoundException("exercises not found");
        }
        return ResponseEntity.ok(exercises.get());
    }
}
