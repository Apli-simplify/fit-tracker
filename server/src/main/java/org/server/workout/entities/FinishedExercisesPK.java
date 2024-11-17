package org.server.workout.entities;

import jakarta.persistence.Column;
import jakarta.validation.constraints.NotNull;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class FinishedExercisesPK implements Serializable {
    @Column(name = "program")
    @NotNull
    private Long program;
    @Column(name = "exercise")
    @NotNull
    private Long exercise;
}
