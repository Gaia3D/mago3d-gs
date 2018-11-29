-- FK, Index �� ���� ���Ϸ� �и�. �� �������� �۾� ����
drop table if exists upload_log cascade;
drop table if exists converter_job cascade;
drop table if exists converter_log cascade;

-- ����� ���� upload �̷�
create table upload_log(
	upload_log_id				bigint,
	user_id						varchar(32),
	file_name					varchar(100)				not null,
	file_real_name				varchar(100)				not null,
	file_path					varchar(256)				not null,
	file_size					varchar(12)					not null,
	file_ext					varchar(10)					not null,
	converter_count				int							default 0,
	insert_date					timestamp with time zone			default now(),
	constraint upload_log_pk	primary key (upload_log_id)	
);

comment on table upload_log is '����� ���� upload �̷�';
comment on column upload_log.upload_log_id is '������ȣ';
comment on column upload_log.user_id is '����� ���̵�';
comment on column upload_log.file_name is '���� �̸�';
comment on column upload_log.file_real_name is '���� ���� �̸�';
comment on column upload_log.file_path is '���� ���';
comment on column upload_log.file_size is '���� ������';
comment on column upload_log.file_ext is '���� Ȯ����';
comment on column upload_log.converter_count is 'F4D Converter ��ȯ Ƚ��';
comment on column upload_log.insert_date is '�����';

-- ����� f4d ��ȯ job
create table converter_job(
	converter_job_id				bigint,
	user_id							varchar(32),
	title							varchar(256)						not null,
	status							char(1)								default '0',
	error_code						varchar(4000),
	insert_date						timestamp with time zone			default now(),
	constraint converter_job_pk primary key (converter_job_id)	
);

comment on table converter_job is '����� f4d ��ȯ �̷�';
comment on column converter_job.converter_job_id is '������ȣ';
comment on column converter_job.user_id is '����� ���̵�';
comment on column converter_job.status is '0: �غ�, 1: ����, 2: ����';
comment on column converter_job.error_code is '���� �ڵ�';
comment on column converter_job.insert_date is '�����';


-- ����� f4d ��ȯ �̷�
create table converter_log(
	converter_log_id				bigint,
	converter_job_id				bigint,
	upload_log_id					bigint,
	user_id							varchar(32),
	status							char(1)								default '0',
	geo_status						char(1)								default '0',
	mapping_type					varchar(30)							default 'origin',
	location		 				GEOGRAPHY(POINT, 4326),
	latitude						numeric(13,10),
	longitude						numeric(13,10),
	height							numeric(7,3),
	heading							numeric(8,5),
	pitch							numeric(8,5),
	roll							numeric(8,5),
	attributes						jsonb,
	error_code						varchar(4000),
	visualize_count					int									default 0,
	insert_date						timestamp with time zone			default now(),
	constraint converter_log_pk primary key (converter_log_id)	
);

comment on table converter_log is '����� f4d ��ȯ �̷�';
comment on column converter_log.converter_log_id is '������ȣ';
comment on column converter_log.converter_job_id is '���� ��ȯ job ������ȣ';
comment on column converter_log.upload_log_id is '���� ���� ������ȣ';
comment on column converter_log.user_id is '����� ���̵�';
comment on column converter_log.status is '����. 0: �غ�, 1: step1, 2: step2, 3: step3, 4: step4';
comment on column converter_log.geo_status is '���� ���� �Է»���. 0: �غ�, 1: ������, 2: �Է� �Ϸ�';
comment on column converter_log.mapping_type is '�⺻�� origin : latitude, longitude, height�� origin�� ����. boundingboxcenter : latitude, longitude, height�� boundingboxcenter ����';
comment on column converter_log.location is '����, �浵 ����';
comment on column converter_log.latitude is '����';
comment on column converter_log.longitude is '�浵';
comment on column converter_log.height is '����';
comment on column converter_log.heading is 'heading';
comment on column converter_log.pitch is 'pitch';
comment on column converter_log.roll is 'roll';
comment on column converter_log.attributes is 'Data Control �Ӽ�';
comment on column converter_log.error_code is '���� �ڵ�';
comment on column converter_log.visualize_count is '�ð�ȭ Ƚ��';
comment on column converter_log.insert_date is '�����';



