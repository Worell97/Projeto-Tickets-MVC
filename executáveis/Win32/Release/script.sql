create database tickets;

use tickets;

create table funcionario (
	id integer not null primary key auto_increment,
    nome varchar(60) not null,
    cpf varchar(15) not null unique,
    situacao varchar(1) not null default "A",
    dataAlteracao datetime not null
);

create table ticket (
	id integer not null primary key auto_increment,
    funcionario integer,
    quantidade integer not null,
    situacao varchar(1) default "A",    
    dataEntrega datetime not null,
    foreign key (funcionario) references funcionario(id)
);

