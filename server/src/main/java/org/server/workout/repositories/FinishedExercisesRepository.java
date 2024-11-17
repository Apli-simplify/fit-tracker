package org.server.workout.repositories;

import org.server.workout.entities.FinishedExcercises;
import org.server.workout.entities.FinishedExercisesPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FinishedExercisesRepository extends JpaRepository<FinishedExcercises, FinishedExercisesPK> {

}
