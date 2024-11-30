package org.server.workout.helpers;

import org.server.workout.dto.AthleteDto;
import org.server.workout.entities.Athlete;

public class AthleteMapping {
    public static AthleteDto map(final Athlete athlete) {
        return AthleteDto.builder()
                .id(athlete.getId())
                .email(athlete.getEmail())
                .password(athlete.getPassword())
                .gender(athlete.getGender())
                .age(athlete.getAge())
                .goal(athlete.getGoal())
                .role(athlete.getRole())
                .height(athlete.getHeight())
                .weight(athlete.getWeight())
                .build();
    }

    public static Athlete map(final AthleteDto athleteDto) {
        return Athlete.builder()
                .id(athleteDto.getId())
                .email(athleteDto.getEmail())
                .name(athleteDto.getName())
                .password(athleteDto.getPassword())
                .age(athleteDto.getAge())
                .gender(athleteDto.getGender())
                .role(athleteDto.getRole())
                .height(athleteDto.getHeight())
                .weight(athleteDto.getWeight())
                .goal(athleteDto.getGoal())
                .build();
    }
}
