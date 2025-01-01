package org.server.workout.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.sql.Date;
import java.sql.Timestamp;

@Getter
@Setter
@Entity
public class Customprogram extends Program {

    @CreationTimestamp
    @Column(name = "creationDate", nullable = true)
    private Timestamp creationDate;

    @Column(name = "status", length = 50)
    private String status;

    @ManyToOne
    @JoinColumn(name = "athlete_id")
    private Athlete athlete;
}
