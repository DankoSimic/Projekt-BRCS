DROP database IF EXISTS domain;
CREATE database domain;
use domain;

# Stavljeni svi inicijalni atributi i dodan bloodline_score koji sam zaboravio
# House maknut not null dok ne napravim house kao entitet
# House dodan natrag
create table regent (
	id_regent int primary key auto_increment not null,
	house int,
	title varchar (50) not null,
	name varchar (50) not null,
	realm varchar (50) not null,
	bloodline varchar (50),
	bloodline_strength varchar (50),
	bloodline_score int,
	class varchar (50),
	level int
);

# Postavljen dio atributa, barem ono što zasad je foreign key
create table domain (
	id_domain int primary key auto_increment not null,
	regent int not null,
	province int not null,
	army int not null
);

# Dodao province zasada samo kako bi stavio veze, poslije dodati jos atributa
# Dodano nesto atributa
create table province (
	id_province int primary key auto_increment not null,
	name varchar (50) not null,
	type varchar (50) not null,
	level int not null,
	avg_gold_income decimal (3,1),
	avg_regency_income decimal (3,1),
	fort boolean
);

# Vidi poslije da li dodati fort upkeep tu kada budes uspostavljao turn, income i expenditure
create table holding (
	id_holding int primary key auto_increment not null,
	province int not null,
	regent int not null,
	type varchar (50) not null,
	level int not null,
	avg_gold_income decimal (3,1),
	avg_regency_income decimal (3,1),
	fort boolean
);

# Za assete kao sto su road, port i ostalo
create table asset (
	id_asset int primary key auto_increment not null,
	province int not null,
	type_asset varchar (50),
	upkeep_asset decimal (2,1)
);

# dodan house, zasada je efektivno placeholder i da mogu dalje rjesit veze, sjeti se reorganizirati redosljed tablica radi preglednosti
# back to blackboard, zasada je house to no vjerojatno ce biti out
create table house (
	id_house int primary key auto_increment not null,
	name varchar (50) not null,
	regent int not null
);

# popisani moguci uniti za feudal,church i free city domenu
# promjenio atribut zbog non standardnog charactera - brabancon pikes
create table army (
	id_army int primary key auto_increment not null,
	german_feudal_knights int,
	german_servant_knights int,
	german_church_knights int,
	order_knights int,
	sergeant_cavalry int,
	sergeant_crossbowmen int,
	sergeant_infantry int,
	burgher_cavalry int,
	burgher_crossbowmen int,
	burgher_infantry int,
	burger_spearmen int,
	militia_crossbowmen int,
	militia_spearmen int,
	feudal_levy int,
	mercenary_knights int,
	mercenary_siege_engineers int,
	mercenary_cavalry int,
	mercenary_crossbowmen int,
	mercenary_infantry int,
	mercenary_irregulars int,
	mercenary_bohemian_cavalry int,
	mercenary_bohemian_crossbowmen int,
	mercenary_bohemian_infantry int,
	mercenary_brabancon_pikemen int,
	mercenary_genoese_crossbowmen int,
	mercenary_spanish_almogavars int
);


# Dodano još nekoliko entiteta koji će trebati
# Razmisli o entitetu character za LT i Regenta pošto će imati zajedničkih podataka

create table treasury (
	id_treasury int primary key auto_increment not null,
	domain int
);

create table item (
	id_item int primary key auto_increment not null,
	treasury int
);

create table lieutenant (
	id_lieutenant int primary key auto_increment not null,
	regent int
);

# Povezan regent s domenom
# Povezan army s domenom
# Povezao ostalo, jos poslije regenta s provincijom
# Povezao house, kao i kod tablica poslije sredi redoslijed house>regent>domena>holding>asset
# Promjenio veze, sredi redoslijed da bude ti preglednije

alter table domain add foreign key (regent) references regent (id_regent);
alter table domain add foreign key (province) references province (id_province);
alter table domain add foreign key (army) references army (id_army);
alter table asset add foreign key (province) references province (id_province);
alter table holding add foreign key (province) references province (id_province);
alter table holding add foreign key (regent) references regent (id_regent);
alter table treasury add foreign key (domain) references domain (id_domain);
alter table item add foreign key (treasury) references treasury (id_treasury);
alter table regent add foreign key (house) references house (id_house);
alter table lieutenant add foreign key (regent) references regent (id_regent);

# Test funkcionalnosti
insert into regent (house,title,name,realm,bloodline,bloodline_strength,bloodline_score,class,level) values
(null,'Baron','Amalia','Holy Roman Empire',null,'Minor',24,'Fighter',2)
;

select * from regent;