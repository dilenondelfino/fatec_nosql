--Oracle Database

create table banco(
    num_banco number(4) primary key,
    nome varchar2(120) not null,
    constraint uq_nome_banco unique(nome)
);

create table estado(
    uf char(2) primary key,
    nome varchar2(120) not null,
    constraint uq_nome_estado unique(nome)
);

create table cidade(
    cod_cid number(5) primary key,
    nome varchar2(120) not null,
    uf char(2) not null,
    constraint fk_cidest foreign key (uf)
            references estado(uf)
);

create table cliente(
    cpf number(11) primary key,
    nome varchar2(120) not null,
    sexo char(2) not null,
    data_nasc date not null,
    constraint ck_sexo_cliente
        check (sexo in ('m', 'f'))
);

create table agencia(
    num_ag number(5),
    num_banco number(4),
    nome varchar2(120) not null,
    cod_cid number(5) not null,
    constraint pk_ag primary key (num_banco, num_ag),
    constraint fk_agbc foreign key (num_banco)
        references banco(num_banco),
    constraint fk_ag_cid foreign key (cod_cid)
        references cidade(cod_cid)
);

create table conta(
    num_conta number(8),
    num_ag number(5),
    num_banco number(4),
    status char(1) not null,
    cpf number(11) not null,
    constraint ck_status_conta check (status in ('s', 'n')),
    constraint pk_cc primary key (num_conta, num_conta, num_ag),
    constraint fk_cc_ag foreign key (num_banco, num_ag)
        references agencia(num_banco, num_ag),
    constraint fk_cc_cli foreign key (cpf)
        references cliente(cpf)
);

create table lancamento(
    num_conta number(8),
    datahora date not null,
    descricao varchar2(120),
    constraint pk_dt_lan primary key (datahora, num_conta),
    constraint fk_lan_cc foreing key (num_conta)
        references conta(num_conta)
);
