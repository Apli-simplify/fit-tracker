package org.server.workout.entities;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Entity
public class Trainer extends User {

    @Column(name = "expertise", nullable = true, length = 100)
    private String expertise;

    @Column(name = "available_status", nullable = true)
    private Byte availableStatus;
}
