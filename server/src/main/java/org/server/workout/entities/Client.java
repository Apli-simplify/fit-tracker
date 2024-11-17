package org.server.workout.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Getter
@Setter
@Entity
public class Client extends User {
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
