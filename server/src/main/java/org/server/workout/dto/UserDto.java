package org.server.workout.dto;
import jakarta.persistence.Column;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.server.workout.enums.RoleUser;

import java.sql.Timestamp;

@SuperBuilder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDto{
    private Long id;
    private String name;
    private String email;
    private String password;
    private Timestamp creationDate;
    private RoleUser role;
}