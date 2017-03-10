INSERT INTO aktivitet (Navn, Beskrivelse) VALUES ('Basketball', 'ballsport');
INSERT INTO aktivitet (Navn, Beskrivelse) VALUES ('Crossfit', 'muskeltrening for å bli ripped');

INSERT INTO treningsøkt (AktivitetsNavn, Navn, Dato, Tidspunkt, Varighet, Form, Notat, Mal) VALUES ('Crossfit', 'Heidi', '2017-01-01', '10:00:00', 60, 3, 'Supermotivert for økta', TRUE);
INSERT INTO treningsøkt (AktivitetsNavn, Navn, Dato, Tidspunkt, Varighet, Form, Notat, Mal) VALUES ('Basketball', 'NBA-økt', '2017-02-02', '14:00:00', 40, 1, 'Ikke motivert for økta', FALSE);
INSERT INTO gruppe (Navn) VALUES ('Overkropp');
INSERT INTO gruppe (Navn) VALUES ('Underkropp');
INSERT INTO øvelse (Navn, Beskrivelse, Typen) VALUES ('Knebøy', 'Sitt ned på huk og reis opp', 'Styrke');
INSERT INTO øvelse (Navn, Beskrivelse, Typen) VALUES ('Militærpress', 'Opp med armene og ned igjen', 'Styrke');
INSERT INTO øvelse (Navn, Beskrivelse, Typen) VALUES ('Jogging', 'Jogg-beskrivelse', 'Kondis');
INSERT INTO kombinasjon (Navn, NavnØvelse2, KombNavn) VALUES ('Militærpress', 'Knebøy', 'Thrusters'); 
INSERT INTO øvelse (Navn, Beskrivelse, Typen) VALUES ('Pushpress', 'press', 'Styrke');


INSERT INTO tilhørerGruppe (NavnØvelse, NavnGruppe) VALUES ('Knebøy', 'Underkropp');
INSERT INTO innendørs (Navn, Dato, Luft, Tilskuere, ID) VALUES ('Heidi', '2017-01-01', 'dårlig aircon', 10, 123);
INSERT INTO utendørs (Navn, Dato, Temperatur, Vind, Værtype, ID) VALUES ('NBA-økt', '2017-02-02', 30, 3, 'sol', 124);
INSERT INTO lignende (Navn, Alternativ) VALUES ('Pushpress', 'Militærpress');

INSERT INTO mål (ID, StartDato, SluttDato, Belastning, Repetisjoner, Sett, LengdeiTid, LengdeiDist, Navn) 
VALUES (125, '2017.01.03', '2017.01.04', 20.5, 20, 20, 60, null, 'Knebøy');  

INSERT INTO mål (ID, StartDato, SluttDato, Belastning, Repetisjoner, Sett, LengdeiTid, LengdeiDist, Navn) 
VALUES (126, '2017.01.03', '2017.01.09', null, null, null, 60, 1000, 'Jogging'); 

INSERT INTO resultat (ID, Belastning, Repetisjoner, Sett, LengdeiTid, LengdeiDist, Navn, Øktnavn, Dato) 
VALUES (127, 25, 29, 2, 30, null, 'Knebøy', 'Heidi', '2017-01-01');

INSERT INTO resultat (ID, Belastning, Repetisjoner, Sett, LengdeiTid, LengdeiDist, Navn, Øktnavn, Dato) 
VALUES (128, null, null, null, 30, 20, 'Jogging', 'NBA-økt', '2017-02-02');

INSERT INTO PulsGPS (Tid, Puls, Lengdegrad, Breddegrad, MOH, Dato, Navn) 
VALUES (20, 156, '30.00.00', '20.00.00', 30, '2017-02-02', 'NBA-økt');

