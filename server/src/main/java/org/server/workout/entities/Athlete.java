package org.server.workout.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.server.workout.enums.Goal;
import org.server.workout.enums.RoleUser;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Entity
public class Athlete extends User {
    @Column(name = "age", nullable = true)
    private Integer age;
    @Column(name = "weight", nullable = true)
    private Double weight;
    @Column(name = "height", nullable = true)
    private Double height;
    @Enumerated(EnumType.STRING)
    @Column(name = "goal", nullable = false)
    private Goal goal;
    @OneToMany(fetch = FetchType.LAZY)
    List<Customprogram> customprograms;
    @OneToMany(fetch = FetchType.LAZY)
    List<Recommendation> recommendations;
}
