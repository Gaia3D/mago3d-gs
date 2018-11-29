drop table if exists server_group cascade;
drop table if exists server_group_server cascade;
drop table if exists server_group_user cascade;
drop table if exists server cascade;

-- ���� �׷�
create table server_group(
	server_group_id				bigint 								not null,
	group_key					varchar(60)			unique			not null ,
	group_name					varchar(100)						not null,
	level						int									default 10,
	ancestor					int								default 0,
	parent						int								default 1,
	depth						int							default 1,
	view_order					int							default 1,
	child_yn					char(1)								default 'N',
	default_yn					char(1)								default 'N',
	use_yn						char(1)								default 'Y',
	description					varchar(256),
	register_date				timestamp with time zone			default now(),
	constraint server_group_pk primary key (server_group_id)	
);

comment on table server_group is '���� �׷�';
comment on column server_group.server_group_id is '������ȣ';
comment on column server_group.group_key is '��ũ Ȱ�� ���� ���� Ȯ�� �÷�';
comment on column server_group.level is '���� ����';
comment on column server_group.group_name is '�׷��';
comment on column server_group.ancestor is '���� ������ȣ';
comment on column server_group.parent is '�θ� ������ȣ';
comment on column server_group.depth is '����';
comment on column server_group.view_order is '���� ����';
comment on column server_group.child_yn is '�ڽ� ��������, Y : ����, N : �������(�⺻)';
comment on column server_group.default_yn is '���� �Ұ�, Y : �⺻, N : ����';
comment on column server_group.use_yn is '�������, Y : ���, N : ������';
comment on column server_group.description is '����';
comment on column server_group.register_date is '�����';

-- ���� �׷캰 Role
create table server_group_role (
	server_group_role_id		bigint 							not null,
	server_group_id				bigint 							not null,
	role_id						bigint	 						not null,
	role_key					varchar(50)						not null,
	register_date				timestamp with time zone			default now(),
	constraint server_group_role_pk primary key (server_group_role_id)
);

comment on table server_group_role is '���� �׷캰 Role';
comment on column server_group_role.server_group_role_id is '������ȣ';
comment on column server_group_role.server_group_id is '���� �׷� ����Ű';
comment on column server_group_role.role_id is 'Role ����Ű';
comment on column server_group_role.role_key is 'Role KEY(�ӵ��� ���� �ߺ�)';
comment on column server_group_role.register_date is '�����';


-- ���� �׷캰 ���� ���
create table server_group_server (
	server_group_server_id		bigint 							not null,
	server_group_id				bigint 							not null,
	server_id					bigint 							not null,
	server_ip 					varchar(45) 					not null,
	register_date				timestamp with time zone			default now(),
	constraint server_group_server_pk primary key (server_group_server_id)
);

comment on table server_group_server is '���� �׷캰 ���� ���';
comment on column server_group_server.server_group_server_id is '������ȣ';
comment on column server_group_server.server_group_id is '���� �׷� ����Ű';
comment on column server_group_server.server_id is '���� ����Ű';
comment on column server_group_server.server_ip is '���� IP(�ӵ��� ���� �ߺ�)';
comment on column server_group_server.register_date is '�����';

-- ���� �׷캰 ����� ���
create table server_group_user (
	server_group_user_id		bigint 							not null,
	server_group_id				bigint 							not null,
	user_id						varchar(32)	 						not null,
	register_date				timestamp with time zone			default now(),
	constraint server_group_user_pk primary key (server_group_user_id)
);

comment on table server_group_user is '���� �׷캰 ����� ���';
comment on column server_group_user.server_group_user_id is '������ȣ';
comment on column server_group_user.server_group_id is '���� �׷� ����Ű';
comment on column server_group_user.user_id is '����� ���̵�';
comment on column server_group_user.register_date is '�����';


-- ����
create table server (
	server_id				bigint					not null,
	server_group_id			bigint,
	server_name				varchar(100)			not null,
	server_ip 				varchar(45) 			not null,
	use_yn 					char(1) 				default 'N',
	api_key 				varchar(256),
	description 			varchar(256),
  	update_date 			timestamp with time zone,
	register_date				timestamp with time zone			default now(),
	constraint server_pk primary key (server_id)	
);



comment on table server is '����';
comment on column server.server_id is '������ȣ';
comment on column server.server_group_id is '������ȣ';
comment on column server.server_name is '������';
comment on column server.server_ip is '���� IP';
comment on column server.use_yn is '�������, Y : ���, N : ������(�⺻)';
comment on column server.api_key is 'API KEY';
comment on column server.description is '����';
comment on column server.update_date is '������';
comment on column server.register_date is '�����';
