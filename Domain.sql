DROP database IF EXISTS domain;
CREATE database domain;
use domain;

# GENERAL
# HOUSE removed as entity and is now an attribute in both regent & lieutenant
# FLEET added as entity

# TABLE ORDER
# 1.CHARACTERS / 1.1. REGENT / 1.2 LIEUTENANT
# 2. / 2.1 DOMAIN / 2.2 PROVINCE / 2.3 ASSET / 2.4 HOLDING
# 3. / 3.1 TREASURY / 3.2 ITEM
# 4. / 4.1 ARMY / 4.2 FLEET 

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

# 2.1 DOMAIN
# CURRENTLY DONE

create table domain (
	id_domain int primary key auto_increment not null,
	name varchar (50) not null,
	regent int not null,
	province int not null,
	army int not null
);

# 2.2 PROVINCE
# CURRENTLY DONE

create table province (
	id_province int primary key auto_increment not null,
	name varchar (50) not null,
	terrain varchar (50) not null,
	level int not null,
	avg_gold_income decimal (3,1),
	avg_regency_income decimal (3,1),
	fort boolean
);

# 2.3 ASSET
# CURRENTLY DONE
# TYPE is for PORT, ROAD, BRIDGE, HOUSE OF WISDOM and similar provincial buildings or non standard assets  

create table asset (
	id_asset int primary key auto_increment not null,
	province int not null,
	type_asset varchar (50),
	upkeep_asset decimal (2,1)
);

# 2.4 HOLDING
# CURRENTLY DONE
# TYPE is for LAW, GUILD, TEMPLE, SOURCE

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

# 3.1 TREASURY
# NOT DONE

create table treasury (
	id_treasury int primary key auto_increment not null,
	domain int,
	gold_bars int,
	regency int
);

# 3.2 ITEM
# NOT DONE

create table item (
	id_item int primary key auto_increment not null,
	treasury int,
	name varchar (50),
	item_type varchar (50),
	item_subtype varchar (50),
	power_description varchar (50),
	consumeable boolean
);

# 4.1 ARMY
# DONE
# ARMY is now simplified

create table army (
	id_army int primary key auto_increment not null,
	unique_units int,
	elf_units int,
	knights int,
	cavalry int,
	crossbowmen int,
	infanry int,
	militia int,
	levy int,
	mercenaries int,
	army_upkeep decimal (5,1)
);

# 4.2 FLEET
# DONE

create table fleet (
	id_fleet int primary key auto_increment not null,
	unique_ships int,
	hulk int,
	cog int,
	crayer int,
	drakkar int,
	knarr int,
	longship int,
	keelboat int,
	navy_upkeep decimal (5,1)
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
