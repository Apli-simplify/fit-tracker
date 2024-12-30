package org.server.workout.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.server.workout.enums.Gender;
import org.server.workout.enums.RoleUser;

import java.sql.Timestamp;
@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Inheritance(strategy = InheritanceType.JOINED)
public class User {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id", nullable = false)
    private Long id;
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    @Column(name = "email", nullable = false, length = 100)
    private String email;
    @Enumerated(EnumType.STRING)
    private Gender gender;
    @Column(name = "password", nullable = false, length = 100)
    private String password;
    @CreationTimestamp
    @Column(name = "creationDate", nullable = true)
    private Timestamp creationDate;
    @UpdateTimestamp
    private Timestamp lastModifiedDate;
    @Column(name="age",nullable = false)
    private Integer age;
    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false)
    private RoleUser role;
}
