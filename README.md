# DBMS

sELECTION --> SELECTING A ROW
PROJECTION --> SELECTING A COLUMN
JOIN --> selecting more than omne column from more than one table


IF there is space in alias name then use "" like  --> empname as "employee name"    otherwise directly   empname as employeename

Distinct can only be used at only first column of slect query  -->  like   select empn, distinct sal from emp ; it is wrong ,, right one is  select distinct  empn, sal from emp ;


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





