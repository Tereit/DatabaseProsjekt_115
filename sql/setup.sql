CREATE SCHEMA treningsdagbok;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON treningsdagbok.* TO 'user'@'localhost';
FLUSH PRIVILEGES;

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
    
INSERT INTO treningsdagbok.aktivitet (Navn, Beskrivelse) VALUES ('Basketball', 'ballsport');
INSERT INTO treningsdagbok.aktivitet (Navn, Beskrivelse) VALUES ('Crossfit', 'muskeltrening for å bli ripped');

INSERT INTO treningsdagbok.treningsøkt (AktivitetsNavn, Navn, Dato, Tidspunkt, Varighet, Form, Notat, Mal) VALUES ('Crossfit', 'Heidi', '2017-01-01', '10:00:00', 60, 3, 'Supermotivert for økta', TRUE);
INSERT INTO treningsdagbok.treningsøkt (AktivitetsNavn, Navn, Dato, Tidspunkt, Varighet, Form, Notat, Mal) VALUES ('Basketball', 'NBA-økt', '2017-02-02', '14:00:00', 40, 1, 'Ikke motivert for økta', FALSE);
INSERT INTO treningsdagbok.gruppe (Navn) VALUES ('Overkropp');
INSERT INTO treningsdagbok.gruppe (Navn) VALUES ('Underkropp');
INSERT INTO treningsdagbok.øvelse (Navn, Beskrivelse, Typen) VALUES ('Knebøy', 'Sitt ned på huk og reis opp', 'Styrke');
INSERT INTO treningsdagbok.øvelse (Navn, Beskrivelse, Typen) VALUES ('Militærpress', 'Opp med armene og ned igjen', 'Styrke');
INSERT INTO treningsdagbok.øvelse (Navn, Beskrivelse, Typen) VALUES ('Jogging', 'Jogg-beskrivelse', 'Kondis');
INSERT INTO treningsdagbok.kombinasjon (Navn, NavnØvelse2, KombNavn) VALUES ('Militærpress', 'Knebøy', 'Thrusters'); 
INSERT INTO treningsdagbok.øvelse (Navn, Beskrivelse, Typen) VALUES ('Pushpress', 'press', 'Styrke');

INSERT INTO treningsdagbok.tilhørerGruppe (NavnØvelse, NavnGruppe) VALUES ('Knebøy', 'Underkropp');
INSERT INTO treningsdagbok.innendørs (Navn, Dato, Luft, Tilskuere, ID) VALUES ('Heidi', '2017-01-01', 'dårlig aircon', 10, 123);
INSERT INTO treningsdagbok.utendørs (Navn, Dato, Temperatur, Vind, Værtype, ID) VALUES ('NBA-økt', '2017-02-02', 30, 3, 'sol', 124);
INSERT INTO treningsdagbok.lignende (Navn, Alternativ) VALUES ('Pushpress', 'Militærpress');

INSERT INTO treningsdagbok.mål (ID, StartDato, SluttDato, Belastning, Repetisjoner, Sett, LengdeiTid, LengdeiDist, Navn) 
VALUES (125, '2017.01.03', '2017.01.04', 20.5, 20, 20, 60, null, 'Knebøy');  

INSERT INTO treningsdagbok.mål (ID, StartDato, SluttDato, Belastning, Repetisjoner, Sett, LengdeiTid, LengdeiDist, Navn) 
VALUES (126, '2017.01.03', '2017.01.09', null, null, null, 60, 1000, 'Jogging'); 

INSERT INTO treningsdagbok.resultat (ID, Belastning, Repetisjoner, Sett, LengdeiTid, LengdeiDist, Navn, Øktnavn, Dato) 
VALUES (127, 25, 29, 2, 30, null, 'Knebøy', 'Heidi', '2017-01-01');

INSERT INTO treningsdagbok.resultat (ID, Belastning, Repetisjoner, Sett, LengdeiTid, LengdeiDist, Navn, Øktnavn, Dato) 
VALUES (128, null, null, null, 30, 20, 'Jogging', 'NBA-økt', '2017-02-02');

INSERT INTO treningsdagbok.PulsGPS (Tid, Puls, Lengdegrad, Breddegrad, MOH, Dato, Navn) 
VALUES (20, 156, '30.00.00', '20.00.00', 30, '2017-02-02', 'NBA-økt');
    