package org.server.workout.service.interfaces;

import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.UserDto;
import org.server.workout.entities.User;

import java.util.List;

public interface UserService {
    AuthenticationResponse register(final UserDto userDto) throws Exception;
    AuthenticationResponse login(final UserDto userDto);
    User findByEmail(String email);
    List<User> getAllUsers();
}
