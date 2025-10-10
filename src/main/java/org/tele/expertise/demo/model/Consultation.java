package org.tele.expertise.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import org.tele.expertise.demo.enums.StatutConsultation;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Entity
@Table(name = "consultation")
public class Consultation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @ManyToOne
    @JoinColumn(name = "medecin_id", nullable = false)
    private Medecin medecin;

    @Column(nullable = false)
    private String motif;

    @Column(length = 2000)
    private String observations;

    @Column(nullable = false)
    private LocalDateTime dateConsultation = LocalDateTime.now();

    @Column(nullable = false)
    private Double cout = 150.0;

    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL)
    private List<ActeTechnique> actes;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private StatutConsultation statut = StatutConsultation.EN_ATTENTE;
}
