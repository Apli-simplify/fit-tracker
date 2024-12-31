package org.server.workout.service.implementations;

import org.server.workout.dto.ProgramDto;
import org.server.workout.entities.Exercise;
import org.server.workout.entities.Program;
import org.server.workout.exceptions.specifics.ResourceNotFoundException;
import org.server.workout.repositories.ProgramRepository;
import org.server.workout.repositories.ExerciseRepository;
import org.server.workout.service.interfaces.ProgramService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
public class ProgramServiceImpl implements ProgramService {

    @Autowired
    private ProgramRepository programRepository;

    @Autowired
    private ExerciseRepository exerciseRepository;

    @Override
    public Optional<List<Program>> GetPrograms() {
        List<Program> programs = programRepository.findNonCustomPrograms();
        return Optional.ofNullable(programs.isEmpty() ? null : programs);
    }
    @Override
    public Optional<List<Program>> GetProgramsCustoms() {
        List<Program> programs = programRepository.findCustomPrograms();
        return Optional.ofNullable(programs.isEmpty() ? null : programs);
    }

    @Override
    public Program addProgram(ProgramDto programDto) {
        Program program = new Program();
        program.setName(programDto.getName());
        program.setTime(programDto.getTime());
        program.setImage(programDto.getImage());

        Set<Exercise> exercises = new HashSet<>();
        for (Exercise exercise : programDto.getExercises()) {
            Optional<Exercise> exerciseOptional = exerciseRepository.findById(exercise.getId());
            if (exerciseOptional.isEmpty()) {
                throw new ResourceNotFoundException("Exercise not found with ID: " + exercise.getId());
            }
            exercises.add(exerciseOptional.get());
        }

        program.setExercises(exercises);

        return programRepository.save(program);
    }
}
