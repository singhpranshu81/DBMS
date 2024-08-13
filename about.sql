SELECT * FROM mphdb.emp;
-- we use InnoDB everytime it is storage management engine. in this we r using different databases
show databases;
show tables;
desc emp; -- describing table
select empno,sal,sal+200 as Bonus from emp;
select empno,sal,deptno from emp where deptno <>20;  -- or use !=
select empno,sal,deptno from emp where deptno=20 or deptno=10; -- use  IN(10,20) or not IN(10,20)
select empno,sal ,deptno from emp where deptno=20 order by 2; -- or use order by 2 --> it will sort by sal
select empno,sal as fgdg,deptno from emp where deptno=20 order by fgdg;
select empno,sal as fgdg,deptno from emp where ename like '_A%';
-- like "A%"  % this eplaces any character but _ replace only one char
-- range operator    beetween and
select empno,sal as fgdg,deptno from emp where sal between 1000 and 3000; -- not between can also be used
-- value is inclusive ,closed interval eg. 1000 and 3000 is taken

select empno,sal as fgdg,deptno, comm from emp where comm is null; --  don't use comm=null always use (is null or is not null) keyword


-- Functions:
-- 1)number based func -- > round(num,position) eg (15.56,1)--.15.6
-- 2) character basd fun
-- 3) date based fun
-- 4) general bsd f
-- 5) group fun or aggregate func
select round(14.56,0);-- 15
select round(14.56,1); -- 14.6
select round(14.56,-1); -- 10
select round(14.56,-2); -- 0

select truncate(14.56,0);-- 14
select truncate(14.56,1); -- 14.5
select truncate(14.56,2); -- 14.56
select truncate(14.56,-1);-- 10   jo bhi -ve number h usme decimal k baad wala hta do, jo bacha usme jitne place(here 2) h sbko zero krdo
select truncate(1454.56,-2); -- 100
select mod(112,2); -- 0
select 112%2; -- or select 112 mod 2

select floor(1.93);
select ceil(1.93);
-- lower("anyname") or upper(ename)
-- concat('Mr.','Singjh')
-- length()
-- reverse("jdj')
-- repeat("hi",3)
-- trim(' RAm  ')
-- substring('jhdj',2,5);  start and end incl.alter
--  DAATE FUNCTIONS
SELECT curdate(),current_date(),current_time(),curtime(); -- curtime same as current_time
select current_timestamp();
select day(),dayname(),dayofmonth(),dayofweek(),dayofyear(); -- () fill ("2024-08-2-01")
 -- learn date function and formatting from net
 -- date_add('2024-08-01',INTERVAL 2 DAY);
 -- date_sub('2024-08-01',INTERVAL 2 DAY);
 -- date_format('2024-02-02 01:02:03','%W %D %M %Y %H %i %S');

-- GROUP FUNCTION --> it ignores null value
-- min(sal),max(sal), avg(),sum(),count()   -- do not give column name after group fun like slct sum(sal),empno from ... don't use empno
---------------------------------------------------------------------------------
-- DATA DICTIONARY table  -- meta data table -- are read only tables
desc information_schema.tables;
select table_name,create_time from information_schema.tables where table_name='emp';

-- read about performance_schema
desc  performance_schema.users;



















-- 1
select * from emp;

-- 2
select distinct job from emp;
-- 3
select ename,job,sal from emp order by sal asc;
-- 4
select ename,deptno,job from emp order by deptno ,job desc;

-- 5
select job as jobs from emp group by job order by job desc;
 -- 6
 select * from emp where mgr is not null;
-- 7
select * from emp where EXTRACT(YEAR FROM hiredate)<1981;

-- 8
select  empno,ename,sal,sal*12 as ann from emp order by ann ;
 -- 9
select empno,ename,job,hiredate ,  DATEDIFF(DATE(NOW()),DATE(hiredate))/365   as exp from emp;
-- 10
select empno,ename,Sal, DATEDIFF(DATE(NOW()),DATE(hiredate))/365   as exp from emp where mgr=7698;

-- 11
select empno,ename from emp where comm>sal;
-- 12
select * from emp where EXTRACT(YEAR FROM hiredate)=1981 and EXTRACT(MONTH FROM hiredate)>6  order by job;

-- 13
select empno,ename,Sal, DATEDIFF(DATE(NOW()),DATE(hiredate))/365  >100 as exp from emp WHERE  (sal/30)>100;
-- 15
select empno,ename,Sal from emp where hiredate IN('1981-05-01','1981-12-03','1981-01-19') order by hiredate;
 -- 16
select empno,ename,Sal from emp where deptno IN(10,20);
-- 17
select * from emp where EXTRACT(YEAR FROM hiredate)=1981;
-- 18
select * from emp where EXTRACT(YEAR FROM hiredate)=1980 and EXTRACT(MONTH FROM hiredate)=7;  
-- 19
select ename,empno,sal*12 as ann from emp where ann between 22000 and 45000;
-- 20
select ename from emp where ename like '_____';

-- can't use alias name in where clause but in grpby can use
--------------------------------------------------------------------
-- GROUP BY

-- use to create sub groups/categories
-- creetes unique records
-- columns in the select list should be available in group by clause 
select job,ename from emp group by job,ename;  

select job from emp group by job,ename; 
-- column within the aggregate function in the select list may or may not be in group by clause
select job,count(ename) from emp group by job;  
-- have the where clause before grp by
select job from emp where job='manager' group by job,ename;

select deptno,max(sal) from emp group by deptno;
-- to put condition in it use having i.e restricting the no.of rows in the grp we use having
select deptno,max(sal) from emp group by deptno having deptno=20;

select job,max(sal) from emp where max(sal)>3000 group by job,ename;-- don't use aggregate function in where clause below one is correct using having

select deptno,max(sal) from emp group by deptno having max(sal)>3000;
select deptno,max(sal) from emp group by deptno having sal>3000;   -- this will throw error bcz column in slelct list must be present in grp by (aggregate function can be there like in above clause max())
select deptno,max(sal) from emp group by deptno,sal having sal>3000;  -- this will work fine


-- 1
select deptno,count(empno) from emp group by deptno;

-- 2
select job , sum(sal) from emp group by job;

-- 3
select count(ename) ,EXTRACT(YEAR FROM hiredate) as hp from emp group by hp;

-- 4
select count(ename) ,mgr from emp group by mgr having mgr is not null;

-- 5
select count(ename),job,deptno from emp group by job,deptno;

-- 6
select sum(sal)*12 ,EXTRACT(YEAR FROM hiredate) as hp from emp group by hp;

-- 7
select avg(sal) ,deptno,job from emp group by deptno,job having job='manager';

--------------------------------------------------------------------------------------------------------
-- JOINS
-- joinning more than one table  to retrieve colums from different tables
--  equi  join or nner join  - a intersection b
-- non-equi join
-- outer join --> left right full ouetr join
-- self join 
-- cross join

-- 1)equi  join 
select e.empno,e.ename,e.job,d.deptno,d.dname from emp e join dept d
 on e.deptno = d.deptno where e.deptno=10;
-- 2) non-equi join
select e.empno,e.ename,e.job,d.deptno,d.dname from emp e join dept d
 on e.deptno=10;
-- 3) left outer
select e.empno,e.ename,e.job,d.deptno,d.dname from emp e left join dept d
 on e.deptno = d.deptno;
-- 4) right
select e.empno,e.ename,e.job,d.deptno,d.dname from emp e right join dept d
 on e.deptno = d.deptno ;
-- 5)cross join
select e.empno,e.ename,e.job,d.deptno,d.dname from emp e cross join dept d;

-- self join --  when u have hierarachy use self join
select m.ename Manager, e.ename Employee from emp as e join emp as m on e.mgr=m.empno; -- employess managaer id is equal to manger employee id go by words

----------
-- 1
select m.ename Manager, e.ename Employee from emp as e join emp as m on e.mgr=m.empno;

-- 2
select e.ename,d.dname from emp as e right join dept as d on e.deptno=d.deptno;

-- 3
select e.ename,d.dname from emp as e right join dept as d on e.deptno=d.deptno where e.ename is null;

-- 4
select e.ename Employee,e.job as JOB ,d.dname as dept from emp as e join dept as d on e.deptno=d.deptno;
-- 5
select ifnull(SUM(e.sal),0),d.dname from emp as e right join dept as d on e.deptno=d.deptno group by d.dname;

-- 21
select ename from emp where ename like 'S%' and length(ename)=5;
-- 22
select ename from emp where ename like '__r%' and length(ename)=4;
-- 23
select ename from emp where ename like 'S%H';
-- 24
select ename from emp where extract(month from hiredate)=1;

-- 25
select ename,HIREDATE from emp where monthname(hiredate) like '_a%';

-- 26
select ename,sal from emp where length(truncate(sal,0))=4 and truncate(sal,0)%10=0;

-- 27
select ename from emp where ename like '%ll%' ;

-- 28
select ename from emp where extract(year from hiredate)=1980;
-- 29
select ename from emp where deptno<>20;
-- 30
select ename ,sal from emp where job not in('PRESIDENT','MGR') order by sal;

-- 31
select ename,hiredate from emp where extract(year from hiredate)<1981 or extract(year from hiredate)>1981 ;
-- 32
select ename from emp where empno not like '78%';

-- 33
select ename,mgr from emp where mgr='7839';

-- 34
select ename,hiredate from emp  where extract(month from hiredate)<>3;

-- 35
select ename from emp where job='clerk' and deptno=20;

----------------------------------------------------------------------
-- CONSTRAINTS
-- 2 types
-- 1)Column level
-- 2)table level

-- primary key  --> no dyuplicate no null
-- unique key --> no duplicate , accept null
-- not null --. accept duplicates , no null
-- check  --> it accepts expression.validate the correctness of data
-- foreign key --> create relationship among table
-- default value --  if value is not given this will be filled

 
 
 
 
 -- TRASACTION (commit ,rollback,savepoint) --> starts with DML ends with TCL(commit, rollback)
 
 -- syntax:
--  START TRANSACTION   --> this will initiate the transaction
--  .....
--  insert insert 
--  savepoint
--  update
--  savepoint
--  delete
--  commit;  or roll back --> end the transaction
--  
 -- if u rollback/commit, all savepoints will be erased
 -- after a commit roll back can't happen
 
create table student (
stid int,
stname varchar(20),
dob date not null,
marks double,
numb int,
dept int
);
 insert into student values(12,'gg','1998-07-07',85.56,15151,2);
 START transaction
 select * from student;
 insert into student values(13,'bb','1998-08-07',87.56,156151,2);
    insert into student values(14,'kk','1999-07-07',83.56,14455,1);
 savepoint A;
 update student set marks=90.12 where stid=14;
 
 savepoint B;
 
  update student set stname='sfjfj' where stid=14;
 rollback to A;
 commit;

-----------------------------------
-- SUB-QUERY  -- the output of one query is input for other and the inner query will be executed only once (exception correlaed querires), outer query can be executed multiple times.
-- inner q. is always independent of outer query except co related
TYPES OF SUB-QUERY:
-- single-row subq  -> inner query will fetch only one value as result
-- multi row s.   -> the inner query will fetch many rows
-- multiple column subq --> the inner query will fetch many rows and columns
-- co related subq --> inner query gets exe. as many times as outer qu.


Single row sub-query
1) whose salary is great tha ALllen salry?
select ename, sal from emp where sal>(select sal from emp where ename='ALLEN'); 

2) query to find who is earning highest sal?
select ename,sal from emp where sal=(select max(sal) from emp );
3) 2nd highest slary
select ename,sal from emp 
where sal=(select max(sal) from  emp where sal<(select max(sal) from emp ));

Multi row subquery
-- IN , ANY ,ALL
ANY and ALL will not work as such. It has to prefixed with any of the rlational operator.
>ANY  --   >MIN
<ANY  --      <MAX
=ANY  ---  IN
>ALL  --  >MAX
<ALL  --- <MIN

1) write a query to find the salary of employees whose salary is equal to the salary of atleast one employee in deptno 30.
-> select ename,job,sal from  emp where sal in(select sal from emp where deptno=30);

--> select ename,job,sal from emp where sal=ANY(select sal from emp where deptno=30);

2)Write query to find the salaryies of employees whose salary is greater than slary of atleast one employee in deptno 30.

 select ename,job,sal from emp where sal>ANY(select sal from emp where deptno=30);

 select ename,job,sal from emp where sal<ANY(select sal from emp where deptno=30);

-- 1
-- select d.dname from dept as d join emp as e on e.deptno=d.deptno where e.sal>ALL(select avg(p.sal) from emp as p group by p.deptno ) group by e.deptno;
-- select dname from emp where sal=(select avg(sal) from emp)

-- 1
select d.dname from dept as d join emp as e on e.deptno=d.deptno group by d.dname
 having avg(e.sal)>(select avg(sal) from emp ) ;
 

-- 2

select d.dname from dept as d join emp as e on e.deptno=d.deptno group by d.dname
 having  max(e.sal)>(select avg(sal) from emp );

-- 3
select d.dname from dept as d join emp as e on e.deptno=d.deptno
where e.sal>2900 group by d.dname having count(e.sal)>2;


----------------------------------------------------------
-- Complex joins
-- retrieve all orders with products and customer details
select order_id,customer_name,product_name 
from customers c join orders o on c.customer_id=o.customer_id
join products p on p.product_id=o.product_id;

-- total number of orders
select p.product_name ,count(order_id) from orders o join products p on o.product_id=p.product_id group by product_name;
-- total revenue generated by each customer
select c.customer_name ,sum(product_price*quantity) as reven
from customers c join orders o on c.customer_id=o.customer_id 
join products p on o.product_id=p.product_id 
group by customer_name limit 1;

-- find the customer who hav not placed ant order
select c.customer_name 
from customers c  left join orders o on c.customer_id=o.customer_id 
-- join products p on o.product_id=p.product_id 
where o.order_id is null;


-- customer names who have placed laptops
 
 select c.customer_name 
from customers c join orders o on c.customer_id=o.customer_id 
join products p on o.product_id=p.product_id 
where p.product_name='Laptop';
 
 
 
 select * from customers; 
select * from products;
select * from Orders;
 
 -------------------------------------------------
 -- VIEWS    -> a virtual table , a table structure will be created, data will be taken from underlined base tabls   w3schools
 -- datas r not stored in views
 -- don't use alter query to alter views, instead OR REPLACE
 
 create view myemp as select * from emp;
 
 select * from myemp;
 
drop view myemp;
create or replace view myemp as select empno,ename,sal from emp;
  select * from myemp;
 desc myemp;
 --------------------------------
 -- Indexing : for faster retrieval of data

 create index myindex on emp(ename,job);
 alter table emp  drop index myindex;
 
 -------------------------
 -- PROCEDURES  -- PL -SQL
 modes -- 3 modes --> IN , OUT , INOUT
 DELIMITER//
 BEGIN
 
 
 END//
 DELIMITER;
 procedure -- will execute but not return anything
 function  --- will return something , have only IN mode
 triggers  --. based on events ,gets executed after events(insert,update,dlete) 
 
 delimiter //
 create procedure proc1(IN cust_id int, OUT cname varchar(20))
 begin
 select customer_name into cname from customers where customer_id= cust_id;
 select count(*) from customers;
 end//
 delimiter ;
 
 call proc1(1,@cname);   -- for oraclee execute proc(), for mysql call
 select @cname;  -- @ is bind variable
 
--  create or replace procedure pro_name
--  alter procedures proc1  drop procedure proc1;
--  
  delimiter //
 create procedure proc2(INOUT timer int, in num int)
 begin
 set timer = timer + num;
 end//
 delimiter ;
 
 set @timer=1;
 call proc2(@timer,1);
 call proc2(@timer,5);
 select @timer;
 
 ------------------------------------------
 -- FUNCTION
 -- if for same set of input u r getting same set of output i.e. deterministic and non-deterministic wherer rsltd can be changed like rand() function
delimiter $$
 create function myfun(custname varchar(20), cuid int)
 returns varchar(20)
 deterministic
 begin
 select customer_name into custname from customers where customer_id=cuid;
 return custname;
 end $$
 delimiter ;
 
 select myfun(@custname,1);
 
  -- 1   retrieve employee by id
  delimiter //
  create procedure proc3(IN cust_id int, OUT cname varchar(20),out jobb varchar(10),out salary int)
 begin
 -- if u want to reduce these out prameters then declre it within begin e.g.
 -- DECLARE cname varchar(20);
 -- DECLARE jobb varchar(10);
 -- declare salary int;
 select ename,job, sal into cname,jobb ,salary from emp where empno=cust_id;
 end//
 delimiter ;
 
 call proc3(7369,@cname,@jobb,@salary);
  select @cname,@jobb,@salary;
 
 -- 2
 delimiter //
 create procedure p3(in deptid int,out cname varchar(20) )
 begin
 select e.ename into cname from emp as e join dept as d  on e.deptno=d.deptno where d.deptno=deptid;
 end//
 delimiter ;
 
 call p3(10,@cname);
 select @cname;
 
 -- 3
  delimiter //
 create procedure p4(OUT salary int,in cname varchar(20),in updatesal int )
 begin
 select sal into salary from emp where ename=cname;
 set salary = salary +updatesal;
 end//
 delimiter ;
 
 call p4(@salary,'smith',200);
 select @salary;
 
 -- 4
  delimiter //
 create procedure p5(in cname varchar(20) )
 begin
 DELETE FROM emp WHERE ename=cname;
 end//
 delimiter ;
 
 call p5('smith');
 
 -- 5
  delimiter //
 create procedure p7(in depti int, out salary int )
 begin
 select sum(e.sal) as s into salary from emp as e join dept as d on e.deptno=d.deptno where d.deptno=depti;
 end//
 delimiter ;

call p7(10,@salary);
select @salary;

-- functions
-- 1
delimiter $$
 create function myfun2(custname varchar(20), cuid int)
 returns varchar(20) 
 deterministic
 begin
 select ename into custname  from emp where empno=cuid;
 return custname;
 end $$
 delimiter ;
 
  select myfun2(@custname,7499);
  
  -- 2
  delimiter $$
  create function m3(deptname varchar(10), de int)
  returns varchar(10)
  deterministic
  begin
  select dname into deptname from dept where deptno=de;
  return deptname;
  end $$
 delimiter ;
 
 select m3(@deptname,10);
 
 -- 3
   delimiter $$
  create function m5(avgsal int)
  returns int
  deterministic
  begin
  select avg(e.sal) as s into avgsal from emp as e join dept as d on e.deptno=d.deptno where d.deptno=30;
  return avgsal;
  end $$
 delimiter ;
 drop function m5;
 select m5(@avgsal);
 
 -- 4
    delimiter $$
  create function m7(empid int)
  returns json
  deterministic
  begin
  declare empinfo json;
  select json_object('empname',ename,'ejob',job)
  into empinfo from emp where sal=empid;
  return empinfo;
  end $$
 delimiter ;
  drop function m7;
 select m7(1600);
 
https://dev.mysql.com/doc/refman/8.4/en/flow-control-statements.html

delimiter //
create procedure itr(C int)
begin
	label1:LOOP
    SET C=C+1;
    IF C<10 THEN
    iterate label1;
    end if;
    leave label1;
    end loop label1;
    set @x=C;
    end// 
delimiter ;
call itr(2);
select(@x);
    drop procedure itr;
    
-----------------------------------------------------
-- Triggers
alter table products add stocks int;
update products
set stocks = CASE
when product_id=101 then 30
when product_id=102 then 20
when product_id=103 then 40
when product_id=104 then 10
when product_id=105 then 80
else stocks
end
where product_id in (101,102,103,104,105);



delimiter //
create trigger afterorderinsert
after insert on orders
for each row
begin
 update products set stocks=stocks - new.quantity
 where product_id=new.product_id;
 end//
 delimiter ;
 
 insert into orders values (8,4,103,5,'2024-03-05');

