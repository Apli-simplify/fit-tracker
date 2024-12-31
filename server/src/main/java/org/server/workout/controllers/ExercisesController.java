package org.server.workout.controllers;

import org.server.workout.entities.Exercise;
import org.server.workout.exceptions.specifics.ResourceNotFoundException;
import org.server.workout.repositories.ExerciseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping
    public ResponseEntity<Exercise> addExercise(@RequestBody Exercise exercise) {
        Exercise savedExercise = exerciseRepository.save(exercise);
        return ResponseEntity.ok(savedExercise);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Exercise> updateExercise(@PathVariable Long id, @RequestBody Exercise exerciseDetails) {
        Exercise exercise = exerciseRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Exercise not found with id: " + id));

        // Update the exercise details
        exercise.setName(exerciseDetails.getName());
        exercise.setTargetArea(exerciseDetails.getTargetArea());
        exercise.setDifficulty(exerciseDetails.getDifficulty());
        exercise.setDescription(exerciseDetails.getDescription());
        exercise.setVideoUrl(exerciseDetails.getVideoUrl());
        exercise.setDuration(exerciseDetails.getDuration());

        Exercise updatedExercise = exerciseRepository.save(exercise);
        return ResponseEntity.ok(updatedExercise);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteExercise(@PathVariable Long id) {
        Exercise exercise = exerciseRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Exercise not found with id: " + id));

        exerciseRepository.delete(exercise);
        return ResponseEntity.noContent().build();
    }
}
