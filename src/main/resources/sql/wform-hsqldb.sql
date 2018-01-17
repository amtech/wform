
CREATE TABLE T_FORM_FIELD  (
  FIELD_ID VARCHAR(32) PRIMARY KEY,
  PAGE_ID VARCHAR(32),-- T_FORM_PAGE.PAGE_ID
  NAME VARCHAR(64),
  DISPLAY VARCHAR(64),
  TYPE VARCHAR(63),
  SIZE INTEGER,
  LAST_UPDATE_DATE TIMESTAMP,
  CREATE_TIME TIMESTAMP DEFAULT NOW(),
  STATUS INTEGER
);

CREATE TABLE T_FORM_FIELD_ATTRIBUTE  (
  PAGE_ID VARCHAR(32),  --T_FORM_PAGE_FIELD_FORM.PK_ID  T_FORM_PAGE_FIELD_LIST.PK_ID
  FIELD_NAME VARCHAR(64),
  ATTR_NAME VARCHAR(64),
  ATTR_VALUE VARCHAR(255),
  STATUS INTEGER
);

CREATE TABLE T_FORM_PAGE  (
  PAGE_ID VARCHAR(32) PRIMARY KEY,
  PAGE_NAME VARCHAR(100),
  PAGE_TITLE VARCHAR(100),
  PAGE_TYPE VARCHAR(10),
  IS_MANUAL INTEGER,
  TABLE_NAME VARCHAR(30),
  SUMMARY VARCHAR(255),
  MODULE_ID VARCHAR(32),
  LAST_UPDATE_DATE TIMESTAMP,
  CREATE_TIME TIMESTAMP DEFAULT NOW(),
  STATUS INTEGER
);

CREATE TABLE T_FORM_MODULE  (
  MODULE_ID VARCHAR(32) PRIMARY KEY,
  MODULE_NAME VARCHAR(100),
  SUMMARY VARCHAR(255),
  LAST_UPDATE_DATE TIMESTAMP(0),
  CREATE_TIME TIMESTAMP(0) DEFAULT NOW(),
  STATUS INTEGER
);

CREATE TABLE T_FORM_PAGE_FIELD_FORM  (
  PK_ID VARCHAR(32) PRIMARY KEY,
  PAGE_ID VARCHAR(32),
  FIELD_ID VARCHAR(32),
  ROW_NUM INTEGER,
  COLUMN_NUM INTEGER,
  COLUMN_SPAN INTEGER,
  EDITABLE INTEGER,
  IS_HIDDEN INTEGER,
  FOR_WORKITEM VARCHAR(36),
  FOR_WORKFLOW VARCHAR(36)
);

CREATE TABLE T_FORM_PAGE_FIELD_LIST  (
  PK_ID VARCHAR(32) PRIMARY KEY,
  PAGE_ID VARCHAR(32),
  FIELD_ID VARCHAR(32),
  ROW_NUM INTEGER,
  COLUMN_NUM INTEGER,
  COLUMN_SPAN INTEGER,
  IS_CONDITION INTEGER,
  FORMATTER VARCHAR(32)
);

CREATE TABLE T_FORM_FLOW (
	PK_ID VARCHAR(32) PRIMARY KEY,
	PAGE_ID VARCHAR(32),
	PD_KEY VARCHAR(255)
);

CREATE TABLE T_WORK_ITEM (
	ITEM_ID VARCHAR(36) PRIMARY KEY,
	BIZ_ID VARCHAR(36) NOT NULL,
	TITLE VARCHAR(255),
	FORM_KEY VARCHAR(255),
	TASK_ID VARCHAR(32),
	TASK_NAME VARCHAR(32),
	CREATE_TIME TIMESTAMP DEFAULT NOW(),
	STATUS INTEGER
);

CREATE TABLE T_CHECKBOX_first_page (
	BIZ_ID VARCHAR(36),
	VALUE VARCHAR(32)
);

CREATE TABLE t_first_group (
	PK_ID VARCHAR(36) PRIMARY KEY,
	title VARCHAR(255),
	note VARCHAR(255),
	content VARCHAR(255)
);

INSERT INTO T_FORM_MODULE (MODULE_ID,MODULE_NAME) VALUES ('100101','firstModule');

INSERT INTO T_FORM_FLOW VALUES('1','1001','simpleApprovalProcess');

update T_FORM_FLOW set PD_KEY = 'simpleApprovalProcess' where PK_ID = '1';

INSERT INTO T_FORM_PAGE_FIELD_FORM VALUES('0','1001','0',1,1,1,1,'bizId',null);
INSERT INTO T_FORM_PAGE_FIELD_FORM VALUES('1','1001','1',1,1,1,1,'title',null);
INSERT INTO T_FORM_PAGE_FIELD_FORM VALUES('2','1001','2',1,1,1,1,null,null);
INSERT INTO T_FORM_PAGE_FIELD_FORM VALUES('3','1001','3',2,1,1,1,null,null);
INSERT INTO T_FORM_PAGE_FIELD_FORM VALUES('4','1001','6',2,2,1,1,null,null);

INSERT INTO T_FORM_PAGE_FIELD_LIST VALUES('0','1001','0',1,1,1,1,null);
INSERT INTO T_FORM_PAGE_FIELD_LIST VALUES('1','1001','1',1,1,1,1,'showLink');
INSERT INTO T_FORM_PAGE_FIELD_LIST VALUES('2','1001','2',1,2,1,0,null);

INSERT INTO T_FORM_PAGE_FIELD_LIST VALUES('3','1002','4',1,1,1,0,null);
INSERT INTO T_FORM_PAGE_FIELD_LIST VALUES('4','1002','5',1,1,1,1,'showLink');
INSERT INTO T_FORM_PAGE_FIELD_LIST VALUES('5','1002','7',1,1,1,0,null);

INSERT INTO T_FORM_FIELD VALUES ('0', NULL, 'pk_id', '主键', 'key', 32, '2017-12-16 20:42:50', '2017-12-16 20:42:52', 1);
INSERT INTO T_FORM_FIELD VALUES ('1', NULL, 'title', '标题', 'text', 255, '2017-12-16 20:42:50', '2017-12-16 20:42:52', 1);
INSERT INTO T_FORM_FIELD VALUES ('2', NULL, 'note', '注释', 'text', 255, '2017-12-16 20:43:44', '2017-12-16 20:43:47', 1);
INSERT INTO T_FORM_FIELD VALUES ('3', NULL, 'content', '内容', 'textarea', 255, '2017-12-16 20:43:44', '2017-12-16 20:43:47', 1);
INSERT INTO T_FORM_FIELD VALUES ('6', NULL, 'love', '爱好', 'checkbox', 255, '2017-12-16 20:43:44', '2017-12-16 20:43:47', 1);

INSERT INTO T_FORM_FIELD VALUES ('4', NULL, 'ITEM_ID', '主键', 'key', 32, '2017-12-16 20:42:50', '2017-12-16 20:42:52', 1);
INSERT INTO T_FORM_FIELD VALUES ('5', NULL, 'TITLE', '标题', 'text', 255, '2017-12-16 20:42:50', '2017-12-16 20:42:52', 1);
INSERT INTO T_FORM_FIELD VALUES ('7', NULL, 'TASK_NAME', '当前任务', 'text', 255, '2017-12-16 20:42:50', '2017-12-16 20:42:52', 1);

INSERT INTO T_FORM_PAGE VALUES ('1001', 'first_page', '第一个页面', 'form', 0,'t_auto_1001','测试', '100101', '2017-12-16 20:14:52', '2017-12-16 20:14:54', 1);
INSERT INTO T_FORM_PAGE VALUES ('1002', 'workItem', '待办列表', 'list', 0,'T_WORK_ITEM','待办', '100101', '2017-12-16 20:14:52', '2017-12-16 20:14:54', 1);
