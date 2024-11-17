package org.server.workout.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@IdClass(FinishedExercisesPK.class)
public class FinishedExcercises {
    @Id
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    @JoinColumn(name = "program", referencedColumnName = "id", insertable = false, updatable = false)
    private Program program;

    @Id
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    @JoinColumn(name = "exercise", referencedColumnName = "id", insertable = false, updatable = false)
    private Exercise exercise;
}
