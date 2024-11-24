package org.server.workout.helpers;

import org.server.workout.dto.AthleteDto;
import org.server.workout.dto.TrainerDto;
import org.server.workout.entities.Athlete;
import org.server.workout.entities.Trainer;

public class TrainerMapping {
    public static TrainerDto map(final Trainer trainer) {
        return TrainerDto.builder()
                .id(trainer.getId())
                .email(trainer.getEmail())
                .password(trainer.getPassword())
                .build();
    }

    public static Trainer map(final TrainerDto trainerDto) {
        return Trainer.builder()
                .id(trainerDto.getId())
                .email(trainerDto.getEmail())
                .name(trainerDto.getName())
                .password(trainerDto.getPassword())
                .build();
    }
}
