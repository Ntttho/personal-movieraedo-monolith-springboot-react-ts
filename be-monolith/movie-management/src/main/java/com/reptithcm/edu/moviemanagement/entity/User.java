package com.reptithcm.edu.moviemanagement.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.Set;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "UserID")
    private Integer userId;

    @Column(name = "Username", nullable = false, unique = true, length = 50)
    private String username;

    @Column(name = "PasswordHash", nullable = false, length = 255)
    private String passwordHash;

    @Column(name = "Email", nullable = false, unique = true, length = 100)
    private String email;

    @Column(name = "Phone", unique = true, length = 20)
    private String phone;

    @Column(name = "FullName", nullable = false, length = 100)
    private String fullName;

    @Column(name = "AvatarURL", length = 255)
    private String avatarUrl;

    @Column(name = "Status", columnDefinition = "VARCHAR(20) DEFAULT 'Active'")
    @Builder.Default
    private String status = "Active";

    @CreationTimestamp
    @Column(name = "CreatedAt", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "UpdatedAt")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "user")
    @Builder.Default
    private Set<UserRole> userRoles = new java.util.HashSet<>();
}
