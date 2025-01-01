package org.server.workout.repositories;

import org.server.workout.entities.Program;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProgramRepository extends JpaRepository<Program, Long> {
    @Query("SELECT p FROM Program p WHERE TYPE(p) = Program")
    List<Program> findNonCustomPrograms();
    @Query("SELECT p FROM Program p WHERE TYPE(p) = Customprogram ")
    List<Program> findCustomPrograms();
}