DROP database IF EXISTS domain;
CREATE database domain;
use domain;

# Stavljeni svi inicijalni atributi i dodan bloodline_score koji sam zaboravio
# House maknut not null dok ne napravim house kao entitet
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
create table province (
	id_province int primary key auto_increment not null
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

# Povezan regent s domenom
# Povezao ostalo, jos poslije regenta s provincijom
alter table domain add foreign key (regent) references regent (id_regent);
alter table domain add foreign key (province) references province (id_province);
alter table asset add foreign key (province) references province (id_province);
alter table holding add foreign key (province) references province (id_province);
alter table holding add foreign key (regent) references regent (id_regent);

# Test funkcionalnosti
insert into regent (house,title,name,realm,bloodline,bloodline_strength,bloodline_score,class,level) values
(null,'Baron','Amalia','Holy Roman Empire',null,'Minor',24,'Fighter',2)
;

select * from regent;