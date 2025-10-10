package org.tele.expertise.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import org.tele.expertise.demo.enums.Acte;

@Data
@Entity
@Table(name = "acte_technique")
public class ActeTechnique {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Acte type;

    @Column(nullable = false)
    private Double cout;

    @ManyToOne
    @JoinColumn(name = "consultation_id", nullable = false)
    private Consultation consultation;
}
