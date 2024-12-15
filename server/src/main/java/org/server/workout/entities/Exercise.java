package org.server.workout.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Exercise {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id", nullable = false)
    private int id;
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    @Column(name = "target_area", nullable = true, length = 100)
    private String targetArea;
    @Column(name = "difficulty", nullable = true, length = 50)
    private String difficulty;
    @Column(name = "description", nullable = true, length = -1)
    private String description;
    @Column(name = "video_url", nullable = true, length = 255)
    private String videoUrl;

}
