package org.server.workout.entities;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Recommendation {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id", nullable = false)
    private Long id;
    @Column(name = "nutrition_advice", nullable = true, length = -1)
    private String nutritionAdvice;
    @Column(name = "exercise_advice", nullable = true, length = -1)
    private String exerciseAdvice;
    @Column(name = "sleep_advice", nullable = true, length = -1)
    private String sleepAdvice;
    @ManyToOne
    @JoinColumn(name = "client_id", referencedColumnName = "id", nullable = false)
    private Athlete athlete;
}
