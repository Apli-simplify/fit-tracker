package org.server.workout.service.implementations;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.AthleteDto;
import org.server.workout.entities.Athlete;
import org.server.workout.helpers.AthleteMapping;
import org.server.workout.helpers.JwtUtil;
import org.server.workout.helpers.UserMapping;
import org.server.workout.repositories.UserRepository;
import org.server.workout.service.interfaces.AthleteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class AthleteServiceImpl implements AthleteService {
    @Autowired
    UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private JwtUtil jwtUtil;

    @Override
    public AuthenticationResponse registerAthlete(AthleteDto athleteDto)  {
            if (userRepository.existsByEmail(athleteDto.getEmail())) {
                return null;
            }
            System.out.println(athleteDto.getGender());
            athleteDto.setPassword(passwordEncoder.encode(athleteDto.getPassword()));
            Athlete athlete = AthleteMapping.map(athleteDto);
            System.out.println(athlete);
            Athlete savedUser = userRepository.save(athlete);
            String jwtToken = jwtUtil.generateToken(UserMapping.mapToCustomUserDetails(savedUser));
            String refreshToken = jwtUtil.generateRefreshToken(UserMapping.mapToCustomUserDetails(savedUser));

            return AuthenticationResponse.builder()
                    .accessToken(jwtToken)
                    .refreshToken(refreshToken)
                    .build();
    }
}
