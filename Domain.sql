DROP database IF EXISTS domain;
CREATE database domain;
use domain;

create table regent (
	id_regent int primary key auto_increment not null,
	house int not null,
	title varchar (50) not null,
	name varchar (50) not null,
	realm varchar (50) not null,
	bloodline varchar (50),
	bloodline_strength varchar (50),
	class varchar (50),
	level int
);

create table domain (
	id_domain int primary key auto_increment not null,
	regent int not null,
	province int not null,
	army int not null
);

alter table domain add foreign key (regent) references regent (id_regent);