--城市公交查询系统

drop table stations;
drop table bus;
drop table admins;

drop sequence seq_sid;
drop sequence seq_bid;
drop sequence seq_aid;

select * from stations;
select * from bus;
select * from admins;

commit

--站点信息(站点编号,站点名称)
create table stations(
    sid int,
    sname varchar2(100)
);
create sequence seq_sid start with 1 increment by 1;

--增加站点
insert into stations values(seq_sid.nextval,'湖南工学院');
insert into stations values(seq_sid.nextval,'崇尚百货');
insert into stations values(seq_sid.nextval,'市图书馆');
insert into stations values(seq_sid.nextval,'南华大学');
insert into stations values(seq_sid.nextval,'衡阳东站');
insert into stations values(seq_sid.nextval,'衡阳火车站');
insert into stations values(seq_sid.nextval,'小西门');
insert into stations values(seq_sid.nextval,'衡阳师院');
insert into stations values(seq_sid.nextval,'南岳衡山');
insert into stations values(9,'解放路口');
insert into stations values(10,'白沙洲');
--修改站点信息
update stations set sname='湖南工学院酃湖校区' where sid=1

--删除站点
delete stations where sid=10




--公交线路(线路编号,线路名称,路线、早班车时间、末班车时间)
create table bus(
     bid int,
     bname varchar2(100),
     bline varchar2(1000),
     bbegin varchar2(100),
     bstop varchar2(100)
);
create sequence seq_bid start with 1 increment by 1;

commit;

--增加公交路线
insert into bus values(seq_bid.nextval,'190路','-4-7-8-9-10-','7:00','18:00')

--修改公交信息
update bus set bname='145路',bline='-4-6-8-3-5-6-',bbegin='5:30',bstop='23:00' where bid=2;

--删除公交信息
delete bus where bid=2;


--查询经过该站点的所有公交
select * from bus where 1=1 and bline like '%-4-%';
select * from bus where 1=1 and bname like '1%'

--区间查询
select * from bus where bline like '%-4-%-3-%'



--管理员表(编号，密码)
create table admins(
     aid int,
     apwd varchar2(100)
);
commit;
select * from admins;
create sequence seq_aid start with 1 increment by 1;
--添加管理员
insert into admins values(seq_aid.nextval,'123456');

--修改密码
update admins set apwd='aaa123' where aid=2

--删除管理员
delete admins where aid=2

--登录
select * from admins where aid=4 and apwd='aaaaaa'



select * from stations where 1=1 and sid= 4

