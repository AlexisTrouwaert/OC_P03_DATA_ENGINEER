create table region
(
    code_region varchar(2)  not null comment 'Code référence region'
        primary key,
    nom_region  varchar(50) null comment 'Nom de la région',
    constraint region_pk_2
        unique (code_region)
);

create table departement
(
    code_departement varchar(3)  not null comment 'Code du departement associé'
        primary key,
    nom_departement  varchar(50) not null comment 'Nom du departement',
    code_region      varchar(2)  not null comment 'Code de la région associé',
    constraint departement_pk_2
        unique (code_departement),
    constraint departement_region_code_region_fk
        foreign key (code_region) references region (code_region)
);

create table commune
(
    code_commune     varchar(6)    not null
        primary key,
    code_departement varchar(3)    not null,
    nom_commune      varchar(50)   not null,
    code_postal      varchar(5)    null,
    latitude         decimal(9, 6) null,
    longitude        decimal(9, 6) null,
    constraint commune_pk
        unique (code_commune),
    constraint commune_departement_code_departement_fk
        foreign key (code_departement) references departement (code_departement)
);

create table type_local
(
    code_type_local bigint      not null
        primary key,
    type_local      varchar(20) not null,
    constraint type_local_pk_2
        unique (code_type_local)
);

create table type_voie
(
    code_type_voie bigint     not null
        primary key,
    type_voie      varchar(5) not null,
    constraint type_voie_pk_2
        unique (code_type_voie)
);

create table adresse
(
    id_adresse     bigint auto_increment
        primary key,
    code_commune   varchar(6)  not null,
    code_type_voie bigint      not null,
    numero_voie    bigint      not null,
    nom_voie       varchar(50) not null,
    b_t_q          varchar(50) null,
    constraint adresse_pk_2
        unique (id_adresse),
    constraint adresse_commune_code_commune_fk
        foreign key (code_commune) references commune (code_commune),
    constraint adresse_type_voie_code_type_voie_fk
        foreign key (code_type_voie) references type_voie (code_type_voie)
);

create table bien
(
    id_bien             bigint auto_increment
        primary key,
    id_adresse          bigint         not null,
    code_type_local     bigint         not null,
    nombre_lots         bigint         not null,
    surface_reelle_bati decimal(7, 2)  not null,
    nombre_pieces       bigint         not null,
    section             varchar(5)     null,
    numero_plan         bigint         null,
    surface_carre       decimal(12, 2) null,
    constraint bien_pk_2
        unique (id_bien),
    constraint bien_adresse_id_adresse_fk
        foreign key (id_adresse) references adresse (id_adresse),
    constraint bien_type_local_code_type_local_fk
        foreign key (code_type_local) references type_local (code_type_local)
);

create table transaction
(
    id_transaction  bigint auto_increment
        primary key,
    id_bien         bigint         not null,
    date_mutation   date           not null,
    valeur_fonciere decimal(15, 2) null,
    nom_acquereur   varchar(50)    not null,
    constraint transaction_pk_2
        unique (id_transaction),
    constraint transaction_bien_id_bien_fk
        foreign key (id_bien) references bien (id_bien)
);

