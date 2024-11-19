package org.server.workout.service.interfaces;

import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.AthleteDto;
import org.server.workout.dto.UserDto;

public interface AthleteService {
    AuthenticationResponse register(final AthleteDto athleteDto) throws Exception;
}
