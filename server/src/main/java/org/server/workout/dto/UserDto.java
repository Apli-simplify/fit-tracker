package org.server.workout.dto;
import jakarta.persistence.Column;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.server.workout.enums.Gender;
import org.server.workout.enums.RoleUser;

import java.net.Inet4Address;
import java.sql.Timestamp;

@SuperBuilder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class UserDto{
    private Long id;
    private String name;
    private String email;
    private String password;
    private Gender gender;
    private Timestamp creationDate;
    private RoleUser role;
    private Integer age;
}