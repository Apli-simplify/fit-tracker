package org.server.workout.service.interfaces;

import org.server.workout.entities.Program;

import java.util.List;
import java.util.Optional;

public interface ProgramService {
    Optional<List<Program>> GetPrograms();
}
