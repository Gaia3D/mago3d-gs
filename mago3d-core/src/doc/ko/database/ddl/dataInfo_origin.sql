-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists data_info_origin cascade;

-- Data 변환전 정보(origin)
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

comment on table data_info_origin is 'Data 정보';
comment on column data_info_origin.data_origin_id is '고유번호';
comment on column data_info_origin.data_id is '고유번호';
comment on column data_info_origin.data_origin_name is 'data 고유 이름';
comment on column data_info_origin.latitude is '위도';
comment on column data_info_origin.longitude is '경도';
comment on column data_info_origin.height is '높이';
comment on column data_info_origin.heading is 'heading';
comment on column data_info_origin.pitch is 'pitch';
comment on column data_info_origin.roll is 'roll';
comment on column data_info_origin.link is '참조 링크';
comment on column data_info_origin.update_date is '수정일';
comment on column data_info_origin.insert_date is '등록일';
