package org.server.workout.dto;

import jakarta.persistence.Column;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.server.workout.entities.Customprogram;
import org.server.workout.enums.Goal;

import java.util.List;
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AthleteDto extends UserDto{
    private Integer age;
    private Double weight;
    private Double height;
    private Goal goal;
}
