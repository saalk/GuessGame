/* Een Prolog-programma bestaat uit feiten en regels. */
/* - alle feiten en regels eindigen met een punt. */
/* - feiten bestaan uit argumenten of verwijzingen naar andere feiten */
/* - regels brengen verband aan tussen 2 of meer feiten of andere regels */

/* - regels bestaan uit een conclusie en 1 of meer voorwaarden */
/* - meerdere voorwaarde zijn gescheiden door een komma */
/* - de conclusie en de voorwaarde worden gescheiden door ':-' */

/* - regels kunnen dezelfde conclusie met verschillende voorwaarden hebben */
/* - deze regels worden geschieden door een ! voor de punt */

/* 1. Regels voor dieren, groepen en subgroepen met hun kenmerken */
/*    de kenmerken met een ', !' zijn onderling uitwisselbaar */
/*    alleen als de een niet geldt, kan de andere ook gelden */

amfibie		:- kenmerk(heeft_kieuwen), !.
amfibie		:- kenmerk(koudbloedig), kenmerk(zwemt), kenmerk(leeft_op_land).
kikker		:- amfibie, kenmerk(is_niet_giftig).
pad			:- amfibie, kenmerk(is_beetje_giftig).
salamander	:- amfibie, kenmerk(heeft_staart).

reptiel		:- kenmerk(heeft_longen), kenmerk(koudbloedig).
slang		:- reptiel, kenmerk(glijdt), kenmerk(is_vaak_giftig).
hagedis		:- reptiel, kenmerk(heeft_staart).
schilpad	:- reptiel, kenmerk(heeft_schild).
krokodil	:- reptiel, kenmerk(heeft_grote_bek), kenmerk(heeft_scherpe_tanden).

vis			:- kenmerk(heeft_kieuwen), kenmerk(zwemt).
zalm		:- vis, kenmerk(roze_kleur_vlees).
aquariumvis :- vis, kenmerk(leeft_in_zoet_water).

zoogdier 	:- kenmerk(warmbloedig), !.
zoogdier    :- kenmerk(geeft_melk).
cheetah 	:- zoogdier, kenmerk(zwarte_vlekken).
tijger  	:- zoogdier, kenmerk(zwarte_strepen).

/* regels voor subgroepen van groepen dieren met extra verwijzingen naar een controle */
hoefdier 	:- zoogdier, kenmerk(heeft_hoeven).
giraf   	:- hoefdier, kenmerk(lange_nek).
zebra   	:- hoefdier, kenmerk(zwarte_strepen).

/* 2. Regel voor kenmerk en voorwaarde ja als antwoord */
/*    het antwoord is volgens de als-dan-anders constructie */
/*    (conditie -> waar ; onwaar), de onwaar is hier ook weer */
/*    een als-dan-anders (conditie -> probeer een ander feit */
/*		en als dat er is ; stel een andere vraag) */
kenmerk(S) 		:- (ja(S) -> true ; (nee(S) -> fail ; vraag(S) )).
vraag(Vraag)	:- write('Heeft het dier het volgende kenmerk: '), 
					write(Vraag), write('? '), read(Antwoord), nl,
					( 	(Antwoord == ja ; Antwoord == j) -> 
						assert(ja(Vraag)) ; assert(nee(Vraag)), fail). 

/* 3. Regels voor alle aannames en dieren voorwaarden */
aanname(cheetah)		:- cheetah, !.
aanname(tijger)     	:- tijger, !.
aanname(giraf)   		:- giraf, !.
aanname(zebra)     		:- zebra, !.
aanname(kikker)			:- kikker, !.
aanname(pad)			:- pad, !.
aanname(salamander)		:- salamander, !.
aanname(slang)			:- slang, !.
aanname(zalm)			:- zalm, !.
aanname(aquariumvis)	:- aquariumvis, !.
aanname(ik_weet_het_niet).            

/* 4. Regels voor de start zonder voorwaarde maar met een aanname  die retract wordt */
go :- aanname(Dier), write('I denk dat het dier is: '), write(Dier), nl, undo.

:- dynamic ja/1,nee/1.
undo 	:- retract(ja(_)),fail. 
undo 	:- retract(nee(_)),fail.
undo.
