--���й�����ѯϵͳ

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

--վ����Ϣ(վ����,վ������)
create table stations(
    sid int,
    sname varchar2(100)
);
create sequence seq_sid start with 1 increment by 1;

--����վ��
insert into stations values(seq_sid.nextval,'���Ϲ�ѧԺ');
insert into stations values(seq_sid.nextval,'���аٻ�');
insert into stations values(seq_sid.nextval,'��ͼ���');
insert into stations values(seq_sid.nextval,'�ϻ���ѧ');
insert into stations values(seq_sid.nextval,'������վ');
insert into stations values(seq_sid.nextval,'������վ');
insert into stations values(seq_sid.nextval,'С����');
insert into stations values(seq_sid.nextval,'����ʦԺ');
insert into stations values(seq_sid.nextval,'������ɽ');
insert into stations values(9,'���·��');
insert into stations values(10,'��ɳ��');
--�޸�վ����Ϣ
update stations set sname='���Ϲ�ѧԺ۹��У��' where sid=1

--ɾ��վ��
delete stations where sid=10




--������·(��·���,��·����,·�ߡ���೵ʱ�䡢ĩ�೵ʱ��)
create table bus(
     bid int,
     bname varchar2(100),
     bline varchar2(1000),
     bbegin varchar2(100),
     bstop varchar2(100)
);
create sequence seq_bid start with 1 increment by 1;

commit;

--���ӹ���·��
insert into bus values(seq_bid.nextval,'190·','-4-7-8-9-10-','7:00','18:00')

--�޸Ĺ�����Ϣ
update bus set bname='145·',bline='-4-6-8-3-5-6-',bbegin='5:30',bstop='23:00' where bid=2;

--ɾ��������Ϣ
delete bus where bid=2;


--��ѯ������վ������й���
select * from bus where 1=1 and bline like '%-4-%';
select * from bus where 1=1 and bname like '1%'

--�����ѯ
select * from bus where bline like '%-4-%-3-%'



--����Ա��(��ţ�����)
create table admins(
     aid int,
     apwd varchar2(100)
);
commit;
select * from admins;
create sequence seq_aid start with 1 increment by 1;
--��ӹ���Ա
insert into admins values(seq_aid.nextval,'123456');

--�޸�����
update admins set apwd='aaa123' where aid=2

--ɾ������Ա
delete admins where aid=2

--��¼
select * from admins where aid=4 and apwd='aaaaaa'



select * from stations where 1=1 and sid= 4

