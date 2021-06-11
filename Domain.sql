DROP database IF EXISTS domain;
CREATE database domain;
use domain;

# GENERAL
# HOUSE removed as entity and is now an attribute in both regent & lieutenant
# FLEET added as entity

# ORDER
# 1.CHARACTERS / "1.1. REGENT" / "1.2 LIEUTENANT"
# 2. / "2.1 DOMAIN" / "2.2 PROVINCE" / "2.3 ASSET" / "2.4 HOLDING"
# 3. / "3.1 TREASURY" / "3.2 ITEM"
# 4. / "4.1 ARMY" / "4.2 FLEET" 
# 5. / "5.1 FOREIGN KEYS"

# "1.1 REGENT"
# CURRENTLY DONE

create table regent (
	id_regent int primary key auto_increment not null,
	title varchar (50) not null,
	name varchar (50) not null,
	race varchar (50) not null,
	house varchar (50) not null,
	dynasty varchar (50) not null,
	realm varchar (50) not null,
	bloodline varchar (50),
	bloodline_strength varchar (50),
	bloodline_score int,
	class varchar (50),
	level int
);

# "1.2 LIEUTENANT"
# CURRENTLY DONE
# TYPE is for Lieutenant, Advisor or Hireling
# REGENT remains not null in case of freelance characters
# HOUSE & DYANSTY remain not null since lieutenants are not neccesarily members of the nobility

create table lieutenant (
	id_lieutenant int primary key auto_increment not null,
	regent int,
	name varchar (50) not null,
	type varchar (50) not null,
	race varchar (50) not null,
	house varchar (50),
	dynasty varchar (50),
	bloodline varchar (50),
	bloodline_strength varchar (50),
	bloodline_score int,
	class varchar (50),
	level int
);

# "2.1 DOMAIN"
# CURRENTLY DONE

create table domain (
	id_domain int primary key auto_increment not null,
	name varchar (50) not null,
	regent int not null
);

# "2.2 PROVINCE"
# CURRENTLY DONE

create table province (
	id_province int primary key auto_increment not null,
	domain int not null,
	name varchar (50) not null,
	terrain varchar (50) not null,
	level int not null,
	avg_gold_income decimal (3,1),
	avg_regency_income decimal (3,1),
	fort boolean
);

# "2.3 ASSET"
# CURRENTLY DONE
# TYPE is for PORT, ROAD, BRIDGE, HOUSE OF WISDOM and similar provincial buildings or non standard assets  

create table asset (
	id_asset int primary key auto_increment not null,
	province int not null,
	type_asset varchar (50),
	upkeep_asset decimal (2,1)
);

# "2.4 HOLDING"
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

# "3.1 TREASURY"
# NOT DONE

create table treasury (
	id_treasury int primary key auto_increment not null,
	domain int,
	gold_bars int,
	regency int
);

# "3.2 ITEM"
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

# "4.1 ARMY"
# DONE
# ARMY is now simplified

create table army (
	id_army int primary key auto_increment not null,
	domain int,
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

# "4.2 FLEET"
# DONE

create table fleet (
	id_fleet int primary key auto_increment not null,
	domain int,
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


# "5.1 FOREIGN KEYS"

alter table domain add foreign key (regent) references regent (id_regent);
alter table province add foreign key (domain) references domain (id_domain);
alter table asset add foreign key (province) references province (id_province);
alter table holding add foreign key (province) references province (id_province);
alter table holding add foreign key (regent) references regent (id_regent);
alter table army add foreign key (domain) references domain (id_domain);
alter table fleet add foreign key (domain) references domain (id_domain);
alter table treasury add foreign key (domain) references domain (id_domain);
alter table item add foreign key (treasury) references treasury (id_treasury);
alter table lieutenant add foreign key (regent) references regent (id_regent);

# DOMAIN insert

insert into regent (title,name,race,house,dynasty,realm,bloodline,bloodline_strength,bloodline_score,class,level) values
("Baron","Amalia von Erzheim","Human","von Erzheim zu Engen","von Erzheim","Holy Auran Empire","Ku","Minor",24,"Warmistress",4),
("Baron","Anastasia von Hirschreich","Elf","von Hirschreich","von Hirschreich","Holy Auran Empire","Unknown","Major",40,"Nightblade",6),
("Duke","Rebecca von Erzheim","Human","von Erzheim","von Erzheim","Holy Auran Empire","Ku","Minor",20,"Unknown",null)
;

insert into lieutenant (regent,name,race,type,class,level) values 
(1,"Wolfgang von Falkenstein","Human","Lieutenant","Fighter",3),
(1,"Ernest von Schaffhausen","Human","Lieutenant","Venturer",3),
(1,"Corrado","Human","Lieutenant","Fighter",3)
;

insert into domain (name,regent) values
("Barony of Engen",1),
("Barony of Stoutgarten",2),
("Duchy of Swabia",3)
;

insert into province (domain,name,terrain,level,avg_gold_income,avg_regency_income,fort) values
(1,"Engen","Hills",8,2,2,1),
(1,"Hulm","Hills",2,1,1,0),
(2,"Stoutgarten","Heavy Forest",2,1,1,0),
(3,"Erzheim","Low Mountains",5,2,2,1),
(3,"Ravenskreuz","Light Forest",5,2,2,1)
;

insert into holding (province,regent,type,level,avg_gold_income,avg_regency_income,fort) values
(1,1,"Law",6,4,4,0),
(1,1,"Guild",2,1,1,0),
(1,1,"Temple",3,1,1,0),
(1,2,"Guild",6,2,2,0),
(2,1,"Law",1,0,0,0),
(3,2,"Law",1,0,0,0),
(3,2,"Source",3,0,0,0)
;

insert into army (domain,unique_units,elf_units,knights,cavalry,crossbowmen,infanry,militia,levy,mercenaries,army_upkeep) values
(1,1,0,2,0,0,0,0,0,0,6)
;

insert into fleet (domain,unique_ships,hulk,cog,crayer,drakkar,knarr,longship,keelboat,navy_upkeep) values
(1,0,0,0,0,0,2,5,15,3)
;

insert into item (name,item_type,item_subtype,power_description,consumeable) values
('Sword of Evergreen Forest','Magic Weapon','Sword','Enhancement +1',0),
('Potion of Healing','Potion','','Healing 1d6',1);

select * from regent;
select * from lieutenant;
select * from province;
select * from holding;
select * from army;
select * from fleet;
select * from item;
