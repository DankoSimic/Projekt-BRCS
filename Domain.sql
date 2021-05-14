DROP database IF EXISTS domain;
CREATE database domain;
use domain;

# Stavljeni svi inicijalni atributi i dodan bloodline_score koji sam zaboravio
create table regent (
	id_regent int primary key auto_increment not null,
	house int not null,
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

# Povezan regent s domenom
alter table domain add foreign key (regent) references regent (id_regent);