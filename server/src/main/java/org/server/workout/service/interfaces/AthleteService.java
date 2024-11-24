package org.server.workout.service.interfaces;

import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.AthleteDto;

public interface AthleteService {
    AuthenticationResponse registerAthlete(final AthleteDto athleteDto) ;
}
