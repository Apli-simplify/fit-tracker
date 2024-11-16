package org.server.workout.entities;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Date;

@Getter
@Setter
@Entity
public class Customprogram extends Program {

    @Column(name = "date")
    private Date date;

    @Column(name = "status", length = 50)
    private String status;

    @ManyToOne
    @JoinColumn(name = "client_id")
    private Client client;
}
