-- FK, Index �� ���� ���Ϸ� �и�. �� �������� �۾� ����
drop table if exists data_info_origin cascade;

-- Data ��ȯ�� ����(origin)
create table data_info_origin(
	data_origin_id				bigint,
	data_id						bigint								not null,
	data_origin_name			varchar(256),
	latitude					numeric(13,10),
	longitude					numeric(13,10),
	height						numeric(7,3),
	heading						numeric(8,5),
	pitch						numeric(8,5),
	roll						numeric(8,5),
	link						varchar(512),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint data_info_origin_pk 	primary key(data_origin_id)
);

comment on table data_info_origin is 'Data ����';
comment on column data_info_origin.data_origin_id is '������ȣ';
comment on column data_info_origin.data_id is '������ȣ';
comment on column data_info_origin.data_origin_name is 'data ���� �̸�';
comment on column data_info_origin.location is '����, �浵 ����';
comment on column data_info_origin.latitude is '����';
comment on column data_info_origin.longitude is '�浵';
comment on column data_info_origin.height is '����';
comment on column data_info_origin.heading is 'heading';
comment on column data_info_origin.pitch is 'pitch';
comment on column data_info_origin.roll is 'roll';
comment on column data_info_origin.link is '���� ��ũ';
comment on column data_info_origin.update_date is '������';
comment on column data_info_origin.insert_date is '�����';
