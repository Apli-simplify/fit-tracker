package org.server.workout.dto;

import jakarta.persistence.Column;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.server.workout.entities.Customprogram;

import java.util.List;
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class AthleteDto extends UserDto{
    private Integer age;
    private String gender;
    private Double weight;
    private Double height;
    private String goal;
}
