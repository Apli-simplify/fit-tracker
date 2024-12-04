package org.server.workout.controllers;

import org.server.workout.entities.Program;
import org.server.workout.exceptions.specifics.ResourceAlreadyExistException;
import org.server.workout.exceptions.specifics.ResourceNotFoundException;
import org.server.workout.service.interfaces.ProgramService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/programs")
public class ProgramController {
    @Autowired
    ProgramService programService;
    @GetMapping
    public ResponseEntity<List<Program>> getAllPrograms() {
        Optional<List<Program>> programs = programService.GetPrograms();

        if (programs.isEmpty() || programs.get().isEmpty()) {
            throw new ResourceNotFoundException("Programs not found");
        }
        return ResponseEntity.ok(programs.get());
    }
}
