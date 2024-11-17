package org.server.workout.service.implementations;
import org.server.workout.config.Authentication.AuthenticationResponse;
import org.server.workout.dto.UserDto;
import org.server.workout.entities.User;
import org.server.workout.helpers.JwtUtil;
import org.server.workout.helpers.UserMapping;
import org.server.workout.repositories.UserRepository;
import org.server.workout.service.interfaces.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import lombok.extern.slf4j.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private JwtUtil jwtUtil;
    @Autowired
    private AuthenticationManager authenticationManager;


    @Override
    public AuthenticationResponse register(UserDto userDto) {

        if (userRepository.existsByEmail(userDto.getEmail())) {
            System.out.println("user already exist");
            return null;
        }
        userDto.setPassword(passwordEncoder.encode(userDto.getPassword()));
        User user = UserMapping.map(userDto);
        User savedUser = userRepository.save(user);
        String jwtToken = jwtUtil.generateToken(UserMapping.mapToCustomUserDetails(savedUser));
        String refreshToken = jwtUtil.generateRefreshToken(UserMapping.mapToCustomUserDetails(savedUser));

        return AuthenticationResponse.builder()
                .accessToken(jwtToken)
                .refreshToken(refreshToken)
                .build();
    }
    @Override
    public AuthenticationResponse login(UserDto userDto) {

        Authentication authenticate = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(userDto.getEmail(), userDto.getPassword()));
        if (authenticate.isAuthenticated()) {
            User savedUser = userRepository.findByEmail(userDto.getEmail());

            System.out.println("isAuthenticated");

            String jwtToken = jwtUtil.generateToken(UserMapping.mapToCustomUserDetails(savedUser));
            String refreshToken = jwtUtil.generateRefreshToken(UserMapping.mapToCustomUserDetails(savedUser));
            return AuthenticationResponse.builder()
                    .accessToken(jwtToken)
                    .refreshToken(refreshToken)
                    .build();
        } else {
            throw new RuntimeException("invalid access");
        }
    }

}
