package org.server.workout.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

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
    @Column(name = "gender", nullable = true, length = 10)
    private String gender;
    @Column(name = "weight", nullable = true)
    private Double weight;
    @Column(name = "height", nullable = true)
    private Double height;
    @Column(name = "goal", nullable = true, length = 50)
    private String goal;
    @OneToMany(fetch = FetchType.LAZY)
    List<Customprogram> customprograms;
    @OneToMany(fetch = FetchType.LAZY)
    List<Recommendation> recommendations;
}
