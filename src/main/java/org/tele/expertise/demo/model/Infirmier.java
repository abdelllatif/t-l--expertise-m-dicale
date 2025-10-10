package org.tele.expertise.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import org.tele.expertise.demo.enums.Role;

@Data
@Entity
@Table(name = "infirmier")
public class Infirmier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nom;

    @Column(nullable = false)
    private String prenom;

    @Column(nullable = false, unique = true)
    private String email;
    @Column(nullable = false)
    private String password;
    @Enumerated(EnumType.STRING)
    private Role role = Role.INFIRMIER;

}
