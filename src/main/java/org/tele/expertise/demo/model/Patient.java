package org.tele.expertise.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Entity
@Table(name = "patient")
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nom;

    @Column(nullable = false)
    private String prenom;

    @Column(nullable = false)
    private int age;

    @Column(nullable = false, unique = true)
    private String cniNumero;

    private String telephone;

    private String adresse;
    @Column(
            nullable = false,
            columnDefinition = "datetime(0) default current_timestamp(0)"
    )
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<SigneVital> signesVitaux;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<Consultation> consultations;

    @OneToOne(mappedBy = "patient", cascade = CascadeType.ALL)
    private FileAttente fileAttente;


}
