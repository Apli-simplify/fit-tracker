package org.server.workout.dto;


import lombok.*;
import lombok.experimental.SuperBuilder;
import org.server.workout.entities.Exercise;

import java.util.Set;

@SuperBuilder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ProgramDto {

    private Long id;
    private String name;
    private Integer time;
    private String image;
    private Set<Exercise> exercises;
}
