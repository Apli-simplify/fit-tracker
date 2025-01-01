package org.server.workout.service.implementations;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.AthleteDto;
import org.server.workout.entities.Athlete;
import org.server.workout.exceptions.specifics.ResourceNotFoundException;
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
            athleteDto.setPassword(passwordEncoder.encode(athleteDto.getPassword()));
            Athlete athlete = AthleteMapping.map(athleteDto);
            Athlete savedUser = userRepository.save(athlete);
            String jwtToken = jwtUtil.generateToken(UserMapping.mapToCustomUserDetails(savedUser));
            String refreshToken = jwtUtil.generateRefreshToken(UserMapping.mapToCustomUserDetails(savedUser));

            return AuthenticationResponse.builder()
                    .accessToken(jwtToken)
                    .refreshToken(refreshToken)
                    .id(savedUser.getId())
                    .build();
    }

    @Override
    public void updateAthlete(Long id, AthleteDto athleteDto) throws ResourceNotFoundException {
        // Find the athlete by ID
        Athlete athlete = (Athlete) userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Athlete not found with id: " + id));

        // Update the athlete's information from the DTO
        athlete.setName(athleteDto.getName());
        athlete.setAge(athleteDto.getAge());
        athlete.setGender(athleteDto.getGender());
        athlete.setWeight(athleteDto.getWeight());
        athlete.setHeight(athleteDto.getHeight());

        // Save the updated athlete to the database
        userRepository.save(athlete);
    }
}
