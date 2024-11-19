package org.server.workout.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Entity
public class Trainer extends User {

    @Column(name = "expertise", nullable = true, length = 100)
    private String expertise;

    @Column(name = "available_status", nullable = true)
    private Byte availableStatus;
}
