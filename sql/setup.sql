create schema treningsdagbok;

create table treningsdagbok.treningsøkt
	(Navn VARCHAR(20) NOT NULL, 
    Dato DATE NOT NULL, 
    Tidspunkt TIME, 
    Varighet INT, 
    Form INT, 
    Notat VARCHAR(140),
    Mal BOOLEAN,
    PRIMARY KEY(Navn, Dato));

create table treningsdagbok.aktivitet
	(Navn VARCHAR(20) NOT NULL, 
    Beskrivelse VARCHAR(140),
    
    PRIMARY KEY(Navn));
    
create table treningsdagbok.utendørs
	(Navn VARCHAR(20) NOT NULL,
    Temperatur INT,
    Vind Double,
    Værtype VARCHAR(50),
    ID INT NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(Navn) REFERENCES aktivitet(Navn) ON DELETE CASCADE ON UPDATE CASCADE);
    
create table treningsdagbok.innendørs
	(Navn VARCHAR(20) NOT NULL,
    Luft VARCHAR(50),
    Tilskuere INT,
    ID INT NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(Navn) REFERENCES aktivitet(Navn) ON DELETE CASCADE ON UPDATE CASCADE);

create table treningsdagbok.øvelse
	(Navn VARCHAR(20) NOT NULL, 
    Beskrivelse VARCHAR(140),
    Typen ENUM('Kondis', 'Styrke'),
    PRIMARY KEY(Navn));

CREATE table treningsdagbok.lignende
	(Navn VARCHAR(20) NOT NULL,
    Alternativ VARCHAR(20) NOT NULL,
    PRIMARY KEY(Navn, Alternativ),
    FOREIGN KEY(Navn) REFERENCES øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Alternativ) REFERENCES øvelse(Navn)ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE table treningsdagbok.kombinasjon
	(Navn VARCHAR(20) NOT NULL,
    NavnØvelse2 VARCHAR(20) NOT NULL,
    KombNavn VARCHAR(20) NOT NULL,
    PRIMARY KEY(Navn, NavnØvelse2),
    FOREIGN KEY(Navn) REFERENCES øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(NavnØvelse2) REFERENCES øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE table treningsdagbok.målresult
	(ID INT NOT NULL,
    Typen ENUM('Mål', 'Resultat'),
    Belastning DOUBLE, 
    Repetisjoner INT, 
    Sett INT,
    LengdeiTid INT,
    LengdeiDist INT,
    Navn VARCHAR(20) NOT NULL,
    Øktnavn VARCHAR(20) NOT NULL,
    Dato DATE NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(Navn) REFERENCES øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Øktnavn) REFERENCES treningsøkt(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Dato) REFERENCES treningsøkt(Dato) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE table treningsdagbok.PulsGPS
	(Tid TIME NOT NULL,
    Puls INT,
    Lengdegrad VARCHAR(20),
    Breddegrad VARCHAR(20),
    MOH INT,
    Dato DATE NOT NULL,
    Navn VARCHAR(20) NOT NULL,
    PRIMARY KEY(Tid, Navn, Dato),
    FOREIGN KEY(Navn) REFERENCES treningsøkt(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Dato) REFERENCES treningsøkt(Dato) ON DELETE CASCADE ON UPDATE CASCADE);
    

CREATE table treningsdagbok.gruppe
	(Navn VARCHAR(20) NOT NULL,
    PRIMARY KEY(Navn));
    
CREATE table treningsdagbok.tilhørerGruppe
	(NavnØvelse VARCHAR(20) NOT NULL,
    NavnGruppe VARCHAR(20) NOT NULL,
    PRIMARY KEY(NavnØvelse, NavnGruppe),
    FOREIGN KEY(NavnØvelse) REFERENCES øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(NavnGruppe) REFERENCES gruppe(Navn) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE table treningsdagbok.delgruppe
	(Delgruppe1 VARCHAR(20) NOT NULL,
    Delgruppe2 VARCHAR(20) NOT NULL,
    PRIMARY KEY(Delgruppe1, Delgruppe2),
    FOREIGN KEY(Delgruppe1) REFERENCES gruppe(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Delgruppe2) REFERENCES gruppe(Navn) ON DELETE CASCADE ON UPDATE CASCADE);