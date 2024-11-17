package org.server.workout.service.interfaces;

import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.UserDto;

import java.util.List;

public interface UserService {
    AuthenticationResponse register(final UserDto userDto) throws Exception;
    AuthenticationResponse login(final UserDto userDto);
}
