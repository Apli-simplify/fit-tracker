package org.server.workout.repositories;

import org.server.workout.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User , Long> {
    User findByEmail(String email);
    boolean existsByEmail(String email);
}
