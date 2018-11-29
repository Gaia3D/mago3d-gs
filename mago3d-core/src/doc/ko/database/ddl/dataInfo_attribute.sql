-- FK, Index �� ���� ���Ϸ� �и�. �� �������� �۾� ����
drop table if exists data_info_attribute cascade;
drop table if exists data_info_object_attribute cascade;


-- Data �⺻����
create table data_info_attribute(
	data_attribute_id			bigint,
	data_id						bigint,
	attributes					json,
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint data_info_attribute_pk 	primary key(data_attribute_id)
);

comment on table data_info_attribute is 'Data ���� ���� �Ӽ� ����';
comment on column data_info_attribute.data_attribute_id is '������ȣ';
comment on column data_info_attribute.data_id is 'Data ������ȣ';
comment on column data_info_attribute.attributes is '�Ӽ�';
comment on column data_info_attribute.update_date is '������';
comment on column data_info_attribute.insert_date is '�����';


create table data_info_object_attribute(
	data_object_attribute_id			bigint,
	data_id								bigint,
	object_id							varchar(256),
	attributes							json,
	update_date							timestamp with time zone,
	insert_date							timestamp with time zone			default now(),
	constraint data_info_object_attribute_pk 	primary key(data_object_attribute_id)
);

comment on table data_info_object_attribute is 'Object �Ӽ� ����';
comment on column data_info_object_attribute.data_object_attribute_id is '������ȣ';
comment on column data_info_object_attribute.data_id is 'Data ������ȣ';
comment on column data_info_object_attribute.attributes is 'Object �Ӽ�';
comment on column data_info_object_attribute.update_date is '������';
comment on column data_info_object_attribute.insert_date is '�����';