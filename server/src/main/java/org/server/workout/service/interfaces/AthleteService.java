package org.server.workout.service.interfaces;

import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.AthleteDto;
import org.server.workout.exceptions.specifics.ResourceNotFoundException;

public interface AthleteService {
    AuthenticationResponse registerAthlete(final AthleteDto athleteDto) ;
    void updateAthlete(Long id, AthleteDto athleteDto) throws ResourceNotFoundException;
}
