drop table if exists file_info cascade;
drop table if exists file_parse_log cascade;

-- ファイル管理（Excel、Pdfなど）
create table file_info(
	file_info_id				bigint,
	user_id						varchar(32)	 		not null,
	job_type					varchar(50)			not null,
	file_name					varchar(100)		not null,
	file_real_name				varchar(100)		not null,
	file_path					varchar(256)		not null,
	file_size					varchar(12)			not null,
	file_ext					varchar(10)			not null,
	total_count					bigint				default 0,
	parse_success_count			bigint				default 0,
	parse_error_count			bigint				default 0,
	insert_success_count		bigint				default 0,
	insert_error_count			bigint				default 0,
	insert_date				timestamp with time zone			default now(),
	constraint file_info_pk primary key (file_info_id)	
);

comment on table file_info is 'ファイル管理';
comment on column file_info.file_info_id is '固有番号';
comment on column file_info.user_id is 'ユーザID';
comment on column file_info.job_type is '業務タイプ';
comment on column file_info.file_name is 'ファイル名';
comment on column file_info.file_real_name is 'ファイル実際の名前';
comment on column file_info.file_path is 'ファイルのパス';
comment on column file_info.file_size is 'ファイルサイズ';
comment on column file_info.file_ext is 'ファイルの拡張子';
comment on column file_info.total_count is 'Excel全体のデータ件数';
comment on column file_info.parse_success_count is 'Excel解析に成功件数';
comment on column file_info.parse_error_count is 'Excel解析エラー';
comment on column file_info.insert_success_count is 'ExcelのデータTarget Table SQL Insert成功件数';
comment on column file_info.insert_error_count is 'ExcelのデータTarget Table SQL Insert失敗件数';
comment on column file_info.insert_date is '登録';

-- ファイル解析履歴（Excel、Pdfなど）
create table file_parse_log(
	file_parse_log_id			bigint,
	file_info_id				bigint 				not null,
	identifier_value			varchar(100)	 		not null,
	error_code					varchar(4000),
	log_type					char(1)				default '0',
	status						char(1)				default '0',
	insert_date				timestamp with time zone			default now(),
	constraint file_parse_log_pk primary key (file_parse_log_id)	
);

comment on table file_parse_log is 'ファイル解析履歴';
comment on column file_parse_log.file_parse_log_id is '固有番号';
comment on column file_parse_log.file_info_id is 'ファイル情報固有の番号';
comment on column file_parse_log.identifier_value is '識別子の値';
comment on column file_parse_log.error_code is 'エラーコード';
comment on column file_parse_log.log_type is 'のログタイプ0：ファイル、1：DB Insert';
comment on column file_parse_log.status is '状態。0：success、1：error';
comment on column file_parse_log.insert_date is '登録';

