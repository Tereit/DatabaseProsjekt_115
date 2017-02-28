create schema treningsdagbok;

CREATE table treningsdagbok.periode
	(FraDato DATE NOT NULL,
    TilDato DATE NOT NULL,
    Navn VARCHAR(20),
    Resultat TEXT,
    Mål TEXT,
    PRIMARY KEY(FraDato, TilDato));

create table treningsdagbok.treningsøkt
	(Navn VARCHAR(20) NOT NULL, 
    Dato DATE NOT NULL, 
    Tidspunkt TIME, 
    Varighet INT, 
    Form INT, 
    Notat VARCHAR(140),
    PRIMARY KEY(Navn, Dato));

create table treningsdagbok.aktivitet
	(Navn VARCHAR(20) NOT NULL, 
    Beskrivelse VARCHAR(140),
    PRIMARY KEY(Navn));

create table treningsdagbok.øvelse
	(Navn VARCHAR(20) NOT NULL, 
    Beskrivelse VARCHAR(140),
    Lengdeitid INT,
    Lengdeidist INT,
    PRIMARY KEY(Navn));

CREATE table treningsdagbok.lignende
	(Navn VARCHAR(20) NOT NULL,
    Alternativ VARCHAR(20) NOT NULL,
    PRIMARY KEY(Navn, Alternativ),
    FOREIGN KEY(Navn) REFERENCES øvelse(Navn),
    FOREIGN KEY(Alternativ) REFERENCES øvelse(Navn));
    
CREATE table treningsdagbok.kombinasjon
	(Navn VARCHAR(20) NOT NULL,
    NavnØvelse2 VARCHAR(20) NOT NULL,
    KombNavn VARCHAR(20) NOT NULL,
    PRIMARY KEY(Navn, NavnØvelse2),
    FOREIGN KEY(Navn) REFERENCES øvelse(Navn),
    FOREIGN KEY(NavnØvelse2) REFERENCES øvelse(Navn));
    
CREATE table treningsdagbok.belastning
	(ID INT NOT NULL,
    Typen ENUM('Mål', 'Resultat'),
    Belastning DOUBLE, 
    Repetisjoner INT, 
    Sett INT,
    Navn VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(Navn) REFERENCES øvelse(Navn));

CREATE table treningsdagbok.PulsGPS
	(Tid TIME NOT NULL,
    Puls INT,
    Lengdegrad VARCHAR(20),
    Breddegrad VARCHAR(20),
    MOH INT,
    Navn VARCHAR(20) NOT NULL,
    PRIMARY KEY(Tid, Navn),
    FOREIGN KEY(Navn) REFERENCES øvelse(Navn));
    

CREATE table treningsdagbok.gruppe
	(Navn VARCHAR(20) NOT NULL,
    PRIMARY KEY(Navn));
    
CREATE table treningsdagbok.tilhørerGruppe
	(NavnØvelse VARCHAR(20) NOT NULL,
    NavnGruppe VARCHAR(20) NOT NULL,
    PRIMARY KEY(NavnØvelse, NavnGruppe),
    FOREIGN KEY(NavnØvelse) REFERENCES øvelse(Navn),
    FOREIGN KEY(NavnGruppe) REFERENCES gruppe(Navn));
