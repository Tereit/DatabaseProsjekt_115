CREATE SCHEMA treningsdagbok;
#CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
#GRANT ALL PRIVILEGES ON treningsdagbok.* TO 'user'@'localhost';
#FLUSH PRIVILEGES;

CREATE TABLE treningsdagbok.aktivitet
	(Navn VARCHAR(20) NOT NULL, 
    Beskrivelse VARCHAR(140),
    PRIMARY KEY(Navn));
    
CREATE TABLE treningsdagbok.treningsøkt
	(AktivitetsNavn VARCHAR(20) NOT NULL,
    Navn VARCHAR(20) NOT NULL, 
    Dato DATE NOT NULL, 
    Tidspunkt TIME, 
    Varighet INT, 
    Form INT, 
    Notat VARCHAR(140),
    Mal BOOLEAN,
    INDEX(Dato),
    PRIMARY KEY(Navn, Dato),
    FOREIGN KEY(AktivitetsNavn) REFERENCES treningsdagbok.aktivitet(Navn) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE TABLE treningsdagbok.utendørs
	(Navn VARCHAR(20) NOT NULL,
    Dato DATE NOT NULL,
    Temperatur INT,
    Vind Double,
    Værtype VARCHAR(50),
    ID INT NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(Navn) REFERENCES treningsdagbok.treningsøkt(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(Dato) REFERENCES treningsdagbok.treningsøkt(Dato) ON DELETE CASCADE ON UPDATE CASCADE);

    
CREATE TABLE treningsdagbok.innendørs
	(Navn VARCHAR(20) NOT NULL,
    Dato DATE NOT NULL,
    Luft VARCHAR(50),
    Tilskuere INT,
    ID INT NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(Navn) REFERENCES treningsdagbok.treningsøkt(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(Dato) REFERENCES treningsdagbok.treningsøkt(Dato) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE treningsdagbok.øvelse
	(Navn VARCHAR(20) NOT NULL, 
    Beskrivelse VARCHAR(140),
    Typen ENUM('Kondis', 'Styrke'),
    PRIMARY KEY(Navn));

CREATE TABLE treningsdagbok.lignende
	(Navn VARCHAR(20) NOT NULL,
    Alternativ VARCHAR(20) NOT NULL,
    PRIMARY KEY(Navn, Alternativ),
    FOREIGN KEY(Navn) REFERENCES treningsdagbok.øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Alternativ) REFERENCES treningsdagbok.øvelse(Navn)ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE TABLE treningsdagbok.kombinasjon
	(Navn VARCHAR(20) NOT NULL,
    NavnØvelse2 VARCHAR(20) NOT NULL,
    KombNavn VARCHAR(20) NOT NULL,
    PRIMARY KEY(Navn, NavnØvelse2),
    FOREIGN KEY(Navn) REFERENCES treningsdagbok.øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(NavnØvelse2) REFERENCES treningsdagbok.øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE TABLE treningsdagbok.resultat
	(ID INT NOT NULL,
    Belastning DOUBLE, 
    Repetisjoner INT, 
    Sett INT,
    LengdeiTid INT,
    LengdeiDist INT,
    Navn VARCHAR(20) NOT NULL,
    Øktnavn VARCHAR(20) NOT NULL,
    Dato DATE NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(Navn) REFERENCES treningsdagbok.øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Øktnavn) REFERENCES treningsdagbok.treningsøkt(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Dato) REFERENCES treningsdagbok.treningsøkt(Dato) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
    CREATE TABLE treningsdagbok.mål
	(ID INT NOT NULL,
    StartDato DATE,
    INDEX(StartDato),
    SluttDato DATE,
    INDEX(SluttDato),
    Belastning DOUBLE, 
    Repetisjoner INT, 
    Sett INT,
    LengdeiTid INT,
    LengdeiDist INT,
    Navn VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(Navn) REFERENCES treningsdagbok.øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE treningsdagbok.PulsGPS
	(Tid TIME NOT NULL,
    Puls INT,
    Lengdegrad VARCHAR(20),
    Breddegrad VARCHAR(20),
    MOH INT,
    Dato DATE NOT NULL,
    Navn VARCHAR(20) NOT NULL,
    PRIMARY KEY(Tid, Navn, Dato),
    FOREIGN KEY(Navn) REFERENCES treningsdagbok.treningsøkt(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Dato) REFERENCES treningsdagbok.treningsøkt(Dato) ON DELETE CASCADE ON UPDATE CASCADE
    );
    

CREATE TABLE treningsdagbok.gruppe
	(Navn VARCHAR(20) NOT NULL,
    PRIMARY KEY(Navn));
    
CREATE TABLE treningsdagbok.tilhørerGruppe
	(NavnØvelse VARCHAR(20) NOT NULL,
    NavnGruppe VARCHAR(20) NOT NULL,
    PRIMARY KEY(NavnØvelse, NavnGruppe),
    FOREIGN KEY(NavnØvelse) REFERENCES treningsdagbok.øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(NavnGruppe) REFERENCES treningsdagbok.gruppe(Navn) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE treningsdagbok.delgruppe
	(Delgruppe1 VARCHAR(20) NOT NULL,
    Delgruppe2 VARCHAR(20) NOT NULL,
    PRIMARY KEY(Delgruppe1, Delgruppe2),
    FOREIGN KEY(Delgruppe1) REFERENCES treningsdagbok.gruppe(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Delgruppe2) REFERENCES treningsdagbok.gruppe(Navn) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE TABLE treningsdagbok.inneholderØvelse
	(NavnØvelse VARCHAR(20) NOT NULL,
    NavnØkt VARCHAR(20) NOT NULL,
    DatoØkt DATE NOT NULL,
    PRIMARY KEY(NavnØvelse, NavnØkt, DatoØkt),
	FOREIGN KEY(NavnØvelse) REFERENCES treningsdagbok.øvelse(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(NavnØkt) REFERENCES treningsdagbok.treningsøkt(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(DatoØkt) REFERENCES treningsdagbok.treningsøkt(Dato) ON DELETE CASCADE ON UPDATE CASCADE);
    