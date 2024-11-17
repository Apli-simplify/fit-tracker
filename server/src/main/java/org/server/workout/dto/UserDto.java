package org.server.workout.dto;
import jakarta.persistence.Column;
import lombok.*;

import java.sql.Timestamp;

@Builder
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
    private String role;
}