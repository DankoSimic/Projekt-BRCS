DROP database IF EXISTS domain;
CREATE database domain;
use domain;

# GENERAL
# HOUSE removed as entity and is now an attribute in both regent & lieutenant

# TABLE ORDER
# 1.CHARACTERS / 1.1. REGENT / 1.2 LIEUTENANT

# 1.1 REGENT
# CURRENTLY DONE

create table regent (
	id_regent int primary key auto_increment not null,
	title varchar (50) not null,
	name varchar (50) not null,
	house varchar (50) not null,
	dynasty varchar (50) not null,
	realm varchar (50) not null,
	bloodline varchar (50),
	bloodline_strength varchar (50),
	bloodline_score int,
	class varchar (50),
	level int
);

# 1.2 LIEUTENANT
# CURRENTLY DONE
# TYPE is for Lieutenant, Advisor or Hireling
# REGENT remains not null in case of freelance characters
# HOUSE & DYANSTY remain not null since lieutenants are not neccesarily members of the nobility

create table lieutenant (
	id_lieutenant int primary key auto_increment not null,
	regent int,
	name varchar (50) not null,
	type varchar (50) not null,
	house varchar (50),
	dynasty varchar (50),
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
	terrain varchar (50) not null,
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
	domain int,
	gold_bars int,
	regency int
);

create table item (
	id_item int primary key auto_increment not null,
	treasury int,
	name varchar (50),
	item_type varchar (50),
	item_subtype varchar (50),
	power_description varchar (50),
	consumeable boolean
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
alter table lieutenant add foreign key (regent) references regent (id_regent);

# Test funkcionalnosti
insert into regent (house,title,name,realm,bloodline,bloodline_strength,bloodline_score,class,level) values
(null,'Baron','Amalia','Holy Roman Empire',null,'Minor',24,'Fighter',2)
;

insert into item (name,item_type,item_subtype,power_description,consumeable) values
('Sword of Evergreen Forest','Magic Weapon','Sword','Enhancement +1',0),
('Potion of Healing','Potion','','Healing 1d6',1);

select * from regent;
select * from item;
