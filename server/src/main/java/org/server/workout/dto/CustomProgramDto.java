package org.server.workout.dto;

import lombok.*;
import lombok.experimental.SuperBuilder;
import org.server.workout.entities.Athlete;

@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CustomProgramDto extends ProgramDto {
    private String status;
    private AthleteDto athleteDto;
}
