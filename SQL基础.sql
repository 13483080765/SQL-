create database Test #创建测试数据库
GRANT SELECT,INSERT,UPDATE,DELETE,create,drop,ALTER ON logistics.*TO test@localhost IDENTIFIED by '123.com'; #授权test用户拥有test数据库增删改查权限
FLUSH PRIVILEGES; #刷新系统权限表
show GRANTS for test@localhost;#查看用户所授予的权限
SHOW DATABASES;#显示所有数据库
drop database Test; #删除测试数据库
drop database Test1; #删除一个不确定存在的数据库 发生错误1008 -
USE logistics #使用数据库
select VERSION() #显示myslq版本
select now(); #显示当前时间
SELECT DAYOFMONTH(CURRENT_DATE); #年
SELECT MONTH(CURRENT_DATE); #月
SELECT YEAR(CURRENT_DATE); #日
SELECT ((4*5)/10)+23; #当计算器用
select database ()
USE logistics
CREATE TABLE `gly`#管理员表
(
	`gon` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,  #管理员编号(主键)
	`gn` VARCHAR(20) not NULL,			#管理员姓名
	`gsex` VARCHAR(2) not NULL,    #管理员性别
	`pw` VARCHAR(20) not null     #管理员密码
);
DROP TABLE gly;#删除管理员表

CREATE TABLE `kh`#客户表
(
	`kno` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL,#客户编号(主键)
	`kn` VARCHAR(20) NOT NULL, #客户姓名
	`ksex` VARCHAR(2) not null,#客户性别
	`ktelephone` VARCHAR(20) NOT null, #客户电话
	`kadress` VARCHAR(200) NOT NULL, #客户地址
	`ksf` VARCHAR(20) NOT NULL #客户身份证号
);
drop TABLES `kh`; #删除客户表
CREATE TABLE yg #员工表
(
	yno BIGINT(20) PRIMARY key auto_increment not NULL,#员工编号
	yn varchar(20) not null,#员工姓名
	ysex varchar(2) not null,#员工性别
	yage TINYINT NOT NULL,#员工年龄
	ytelephone VARCHAR(20) not null,#员工电话
	yposition varchar(20) NOT NULL#员工职务
);
DROP TABLE yg;#删除员工表
create table hw #货物表
(
	hwno BIGINT(20) PRIMARY KEY auto_increment not null,#货物编号
	hwn VARCHAR(20) not null,#货物名称
	hwkind varchar(40) not null,#货物类型
	hwweight VARCHAR(10) not NULL#货物重量
);
DROP TABLE hw;#删除货物表
CREATE table ck #仓库表
(
	ckno BIGINT(20) PRIMARY KEY auto_increment not null,#仓库编号
	ckn VARCHAR(20) not null,#仓库名称
	ckcapacity VARCHAR(10) not NULL#仓库容量
);
DROP TABLE ck;#删除仓库表
CREATE TABLE shr #收货人表
(
	sno BIGINT(20) PRIMARY key auto_increment not NULL,#收货人编号
	sn varchar(20) not null,#收货人姓名
	ssex	varchar(2) not null,#收货人性别
	sadress VARCHAR(200) NOT NULL, #收货人地址
	stelephone VARCHAR(20) not null#收货人电话
);
DROP TABLE shr;#删除收货人表
CREATE TABLE hd #货单表
(
	hdno BIGINT(20) PRIMARY key auto_increment not NULL,#货单编号
	hdprice VARCHAR(10) not null,#运费总价
	hdn varchar(20) not null,#货单名称
	sno BIGINT(20) not NULL,#收货人编号(主键)
	yno BIGINT(20) not NULL,#员工编号(主键)
	kno BIGINT(20) NOT NULL,#客户编号(主键)
	hwno BIGINT(20)  not null,#货物编号(主键)
	constraint FK_sno FOREIGN key(sno) REFERENCES shr(sno),#收货人编号(外键)
	constraint FK_yno FOREIGN key(yno) REFERENCES yg(yno),#员工编号(外键)
	constraint FK_kno FOREIGN key(kno) REFERENCES kh(kno),#客户编号(外键)
	constraint FK_hwno FOREIGN key(hwno) REFERENCES hw(hwno)#货物编号(外键)
);
DROP TABLE hd;#删除货单表
CREATE TABLE cc #存储表
(
	ccno BIGINT(20) PRIMARY key auto_increment not NULL,#存储编号
	ccstortime datetime NOT NULL,#入库时间
	ccouttime datetime NOT NULL,#出库时间
	ccsquantity varchar(20) not null,#入库数量
	ccoquantity varchar(20) not null,#出库数量
	yno BIGINT(20) not NULL,#员工编号(主键)
	ckno BIGINT(20) not null,#仓库编号(主键)
	hwno BIGINT(20)  not null,#货物编号(主键)
	constraint FK_yg FOREIGN key(yno) REFERENCES yg(yno),#员工编号(外键)
	constraint FK_ck FOREIGN key(ckno) REFERENCES ck(ckno),#仓库编号(外键)
	constraint FK_hw FOREIGN key(hwno) REFERENCES hw(hwno)#货物编号(外键)
);
DROP TABLE cc;#删除存储表
CREATE TABLE ps #配送表
(
	psno BIGINT(20) PRIMARY key auto_increment not NULL,#配送编号
	sno BIGINT(20) not NULL,#收货人编号(主键)
	yno BIGINT(20) not NULL,#员工编号(主键)
	ckno BIGINT(20) not null,#仓库编号(主键)
	ppicktime datetime NOT NULL,#接货时间
	pdelitime datetime NOT NULL,#发货时间
	psfs varchar(20) not null,#配送方式
	fsn datetime not null,#配送时间
	constraint FK_shrid FOREIGN key(sno) REFERENCES shr(sno),#收货人编号(外键)
	constraint FK_ygid FOREIGN key(yno) REFERENCES yg(yno),#员工编号(外键)
	constraint FK_ckid FOREIGN key(ckno) REFERENCES ck(ckno)#仓库编号(外键)
);
DROP TABLE ps;#删除配送表
show TABLES; #显示所有表
CREATE DATABASE Logistics; #创建logistics
show variables like 'logi%';
set logistics=utf8;
alter table logistics character set utf8;
alter table logistics convert to character set utf8;


/* 插入数据*/
INSERT INTO gly (gn,gsex,pw)#添加管理员
VALUES
('wxs','男','123.com'),
('zxs','男','123.com'),
('lxs','男','123.com');
delete FROM gly where gon=1 #删除一条数据
truncate gly; #清空管理员表（自增长从1开始）
alter gly jx_pcmx AUTO_INCREMENT 20;
INSERT INTO kh (kn,ksex,ktelephone,kadress,ksf)#添加客户信息
VALUES
('王先生','男','13483080760','河北省邯郸市大名县','130425000000000001'),
('李先生','男','13483080761','河北省邯郸市魏县','130425000000000002'),
('张先生','男','13483080762','河北省邯郸市邯山区','130425000000000003'),
('朱先生','男','13483080763','河北省邯郸市复兴区','130425000000000004'),
('赵先生','男','13483080764','河北省邯郸市临漳县','130425000000000005'),
('孙女士','女','13483080765','河北省邯郸市肥乡区','130425000000000006'),
('周女士','女','13483080766','河北省邯郸市广平县','130425000000000007'),
('王女士','女','13483080767','河北省邯郸市成安县','130425000000000008'),
('朱女士','女','13483080767','河北省邯郸市大名县','130425000000000009');

INSERT INTO yg (yn,ysex,yage,ytelephone,yposition)#添加员工信息
VALUES
('张三','男','34','13483080760','项目经理'),
('李四','男','30','13483080761','项目组长'),
('王五','男','27','13483080762','配送员'),
('马六','男','25','13483080763','配送员'),
('赵七','男','24','13483080764','配送员');

INSERT INTO hw (hwn,hwkind,hwweight)#添加货物信息
VALUES
('伊利牛奶','饮食品','12kg'),
('新鲜牛肉片','饮食品','3kg'),
('达利园面包','饮食品','1kg'),
('语文课本','文体用具','100g'),
('男士T恤','衣','200g'),
('黑人牙膏','百货','58g'),
('医用酒精','化工原料','26g'),
('玻璃杯','玻璃','630g'),
('药酒','酒','450g'),
('人工大理石','矿石','3000kg'),
('桶装汽油','石油','210kg'),
('汉白玉','矿石','230kg'),
('袋装水泥','建设材料','500kg'),
('不锈钢','金属材料','750g'),
('枕木','木材','600kg');

INSERT INTO ck (ckn,ckcapacity)#添加仓库信息
VALUES
('A华北仓库','745m³'),
('B华南仓库','950m³'),
('C华中仓库','860m³'),
('D华东仓库','718m³');

INSERT INTO shr (sn,ssex,sadress,stelephone)#添加收货人信息
VALUES
('A先生','男','河北省邯郸市大名县','13483080760'),
('B先生','男','河北省邯郸市魏县','13483080761'),
('C先生','男','河北省邯郸市成安县','13483080762'),
('D先生','男','河北省邯郸市复兴区','13483080763'),
('E女士','女','河北省邯郸市大名县','13483080764'),
('F女士','女','河北省邯郸市邯山区','13483080765'),
('G女士','女','河北省邯郸市成安县','13483080766'),
('H女士','女','河北省邯郸市魏县','13483080767'),
('I女士','女','河北省邯郸市成安县','13483080768'),
('L女士','女','河北省邯郸市邯山区','13483080769');

INSERT into hd(hdprice,hdn,sno,yno,kno,hwno)#添加货单信息
VALUES
('20','H0001','2','3','4','2'),
('14','H0002','1','2','2','8'),
('20','H0003','6','1','6','15'),
('20','H0004','8','4','8','4'),
('20','H0005','9','5','3','10');

INSERT into cc(ccstortime,ccouttime,ccsquantity,ccoquantity,yno,ckno,hwno)#添加存储信息
VALUES
('2020-5-6 8:15:20','2020-5-9 16:38:32','100','65','3','2','3'),
('2020-5-3 9:42:17','2020-5-6 18:24:06','60','20','4','4','12'),
('2020-5-2 8:21:56','2020-5-4 15:52:45','80','45','5','3','7'),
('2020-5-1 8:08:13','2020-5-2 17:20:47','50','35','2','3','6'),
('2020-4-28 8:35:38','2020-5-1 18:18:03','70','60','1','1','9');

INSERT into ps(sno,yno,ckno,ppicktime,pdelitime,psfs,fsn)#添加配送信息
VALUES
('3','5','2','2020-5-5 16:36:17','2020-5-5 8:16:53','准时配送','2020-5-5 9:07:17'),
('2','3','3','2020-5-4 18:15:02','2020-5-4 9:12:29','准时配送','2020-5-4 10:39:40'),
('6','2','3','2020-5-3 17:01:41','2020-5-3 9:02:15','共同配送','2020-5-3 10:06:31'),
('9','4','4','2020-5-3 16:38:56','2020-5-3 8:47:50','定时配送','2020-5-3 9:31:46'),
('4','1','1','2020-5-2 15:22:38','2020-5-2 9:08:04','准时配送','2020-5-2 8:18:02');


/*事务*/

/*视图*/
-- 原始查询
select DISTINCT kh.kno as 客户ID, kh.kn as 客户姓名,kh.ksex as 客户性别,kh.kadress as 客户地址,kh.ktelephone as 客户联系电话,yg.yn as 员工姓名,yg.ysex as 员工性别,yg.ytelephone as 员工联系电话,yg.yposition as 职位
from (kh as kh INNER JOIN yg as yg ON kh.kno=yg.yno);
-- 创建视图
CREATE VIEW
v_kh(kno,kn,ksex,ktelephone,yn,ysex,ytelephone,yposition)
as select kh.kno,kh.kn,kh.ksex,kh.ktelephone,yg.yn,yg.ysex,yg.ytelephone,yg.yposition
from (kh as kh INNER JOIN yg as yg ON kh.kno=yg.yno);
-- 视图查询
select * from v_kh where kno='1';
show TABLES;
show tables like 'v_%'; -- 模糊检索查询v_视图
-- 查看视图
desc v_kh;
show fields from v_yg;
-- 视图修改
update kh set kn='钢铁侠',ksex='女'where kno=3;
COMMIT; -- 数据提交
select * from v_kh where kno=3; -- 通过视图检索查看修改后数据
-- 视图插入数据
insert into v_kh (kno,kn,ksex,ktelephone) 
values(10,'张国企','男','134830');
-- With CHECK OPTION 命令 年龄>=40
CREATE VIEW v_yg AS
SELECT * from yg where yage>=40
WITH CHECK OPTION;
-- v_yg视图插入数据
insert INTO v_yg (yn,ysex,yage,ytelephone,yposition) values('赵七','男','44','13483080764','配送员');
-- 删除v_yg视图
DROP VIEW v_yg;
-- 未加With CHECK OPTION 命令 年龄>=40
CREATE VIEW v_yg 
AS
SELECT * from yg where yage>=40
insert INTO v_yg (yn,ysex,yage,ytelephone,yposition) values('赵七','男','20','13483080764','配送员');
select * from v_yg;
-- 修改v_yg视图
update v_yg set yage=50 where yno=6;