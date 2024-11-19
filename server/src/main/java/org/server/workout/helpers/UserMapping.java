package org.server.workout.helpers;

import org.server.workout.config.Authentication.CustomUserDetails;
import org.server.workout.dto.UserDto;
import org.server.workout.entities.User;

public class UserMapping{
    public static UserDto map(final User user) {
        return UserDto.builder()
                .id(user.getId())
                .email(user.getEmail())
                .role(user.getRole())
                .build();
    }

    public static User map(final UserDto userDto) {
        return User.builder().name(userDto.getName()).email(userDto.getEmail()).password(userDto.getPassword()).role(userDto.getRole()).build();
    }
    public static CustomUserDetails mapToCustomUserDetails(final User user) {
        return CustomUserDetails.builder()
                .id(user.getId())
                .email(user.getEmail())
                .password(user.getPassword())
                .role(user.getRole().name())
                .build();
    }
}








