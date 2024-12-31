package org.server.workout.service.implementations;

import org.server.workout.entities.Program;
import org.server.workout.repositories.ProgramRepository;
import org.server.workout.service.interfaces.ProgramService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProgramServiceImpl implements ProgramService {

    @Autowired
    private ProgramRepository programRepository;

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
}
