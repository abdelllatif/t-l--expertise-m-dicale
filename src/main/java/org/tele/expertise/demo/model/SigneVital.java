package org.tele.expertise.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "signes_vitaux")
public class SigneVital {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Double tensionArt;

    @Column(nullable = false)
    private Integer frequenceCardiaque;

    @Column(nullable = false)
    private Double temperature;

    @Column(nullable = false)
    private Integer frequenceRespiratoire;

    private Double poids;

    private Double taille;

    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @Column(nullable = false)
    private LocalDateTime dateMesure = LocalDateTime.now();
}
