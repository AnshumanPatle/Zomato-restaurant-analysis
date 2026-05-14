CREATE DATABASE Zomato;

USE Zomato;

CREATE TABLE dept (
 deptno INT PRIMARY KEY,
 dname VARCHAR(20),
 loc VARCHAR(20)
);

INSERT INTO dept VALUES
(10, 'OPERATIONS', 'BOSTON'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'ACCOUNTING', 'NEW YORK');

Select * From dept;

CREATE TABLE emp (
    empno    INT NOT NULL,
    ename    VARCHAR(10),
    job      VARCHAR(9) DEFAULT 'CLERK',
    mgr      INT(4),
    hiredate DATE,
    sal      DECIMAL(7,2) CHECK (sal > 0),
    comm     DECIMAL(7,2),
    deptno   INT(2),

    CONSTRAINT pk_empno PRIMARY KEY (empno),
    CONSTRAINT fk_deptno FOREIGN KEY (deptno)
        REFERENCES dept(deptno)
);

INSERT INTO emp VALUES (7369,'SMITH','CLERK',7902,DATE '1980-12-17',800,NULL,20);
INSERT INTO emp VALUES (7499,'ALLEN','SALESMAN',7698,DATE '1981-02-20',1600,300,30);
INSERT INTO emp VALUES (7521,'WARD','SALESMAN',7698,DATE '1981-02-22',1250,500,30);
INSERT INTO emp VALUES (7566,'JONES','MANAGER',7839,DATE '1981-04-02',2975,NULL,20);
INSERT INTO emp VALUES (7654,'MARTIN','SALESMAN',7698,DATE '1981-09-28',1250,1400,30);
INSERT INTO emp VALUES (7698,'BLAKE','MANAGER',7839,DATE '1981-05-01',2850,NULL,30);
INSERT INTO emp VALUES (7782,'CLARK','MANAGER',7839,DATE '1981-06-09',2450,NULL,10);
INSERT INTO emp VALUES (7788,'SCOTT','ANALYST',7566,DATE '1987-04-19',3000,NULL,20);
INSERT INTO emp VALUES (7839,'KING','PRESIDENT',NULL,DATE '1981-11-17',5000,NULL,10);
INSERT INTO emp VALUES (7844,'TURNER','SALESMAN',7698,DATE '1981-09-08',1500,0,30);
INSERT INTO emp VALUES (7876,'ADAMS',DEFAULT,7788,DATE '1987-05-23',1100,NULL,20);
INSERT INTO emp VALUES (7900,'JAMES','CLERK',7698,DATE '1981-12-03',950,NULL,30);
INSERT INTO emp VALUES (7902,'FORD','ANALYST',7566,DATE '1981-12-03',3000,NULL,20);
INSERT INTO emp VALUES (7934,'MILLER','CLERK',7782,DATE '1982-01-23',1300,NULL,10);


select * from emp;

#1.	Create the Employee Table as per the Below Data Provided

select * from emp;

#2 Create the Dept Table as below

select * from dept;

#3.	List the Names and salary of the employee whose salary is greater than 1000

SELECT ename, sal
FROM emp
WHERE sal > 1000;


#4.	List the details of the employees who have joined before end of September 81.

SELECT *
FROM emp
WHERE hiredate < '1981-10-01';

#5.	List Employee Names having I as second character.

SELECT ename
FROM emp
WHERE ename LIKE '_I%';

#6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns

SELECT 
    ename AS Employee_Name,
    sal   AS Salary,
    sal * 0.40 AS Allowances,
    sal * 0.10 AS PF,
    sal + (sal * 0.40) - (sal * 0.10) AS Net_Salary
FROM emp;

#7. List Employee Names with designations who does not report to anybody

SELECT ename, job
FROM emp
WHERE mgr IS NULL;

#8.	List Empno, Ename and Salary in the ascending order of salary.

SELECT empno, ename, sal
FROM emp
ORDER BY sal ASC;


#9. How many jobs are available in the Organization ?

SELECT COUNT(DISTINCT job) AS Total_Jobs
FROM emp;

#10. Determine total payable salary of salesman category

SELECT SUM(sal) AS Total_Payable_Salary
FROM emp
WHERE job = 'SALESMAN';

#11. List average monthly salary for each job within each department 

SELECT 
    deptno,
    job,
    AVG(sal) AS Avg_Monthly_Salary
FROM emp
GROUP BY deptno, job;

# 12.	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.

SELECT 
    e.ename AS Employee_Name,
    e.sal   AS Salary,
    d.dname AS Department_Name
FROM emp e
JOIN dept d
ON e.deptno = d.deptno;


#13. Create the Job Grades Table as below

CREATE TABLE job_grades (
    grade       CHAR(1) PRIMARY KEY,
    lowest_sal  INT,
    highest_sal INT
);

INSERT INTO job_grades VALUES
('A', 0, 999),
('B', 1000, 1999),
('C', 2000, 2999),
('D', 3000, 3999),
('E', 4000, 5000);

select * from job_grades;

#14. Display the last name, salary and  Corresponding Grade.

SELECT e.ename AS Employee_Name,e.sal   AS Salary,j.grade AS Grade
FROM emp e
JOIN job_grades j
ON e.sal BETWEEN j.lowest_sal AND j.highest_sal;


# 15.	Display the Emp name and the Manager name under whom the Employee works in the below format . Emp Report to Mgr.

SELECT E.ENAME AS "Emp",M.ENAME AS "Report to Mgr"
FROM EMP E
LEFT JOIN EMP M ON E.MGR = M.EMPNO;
    
    
    
#16. Display Empname and Total sal where Total Sal (sal + Comm)

SELECT 
    ENAME AS `Emp Name`,SAL + IFNULL(COMM, 0) AS `Total Sal`FROM EMP
LIMIT 1000;

#17. Display Empname and Sal whose empno is a odd number

SELECT 
    ENAME AS `Emp Name`,SAL AS `Salary`
FROM EMP
WHERE MOD(EMPNO, 2) = 1;
    
#18. Display Empname , Rank of sal in Organisation , Rank of Sal in their department

SELECT 
    ENAME AS `Emp Name`,
    RANK() OVER (ORDER BY SAL DESC) AS `Org Rank`,
    RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) AS `Dept Rank`
FROM EMP;
    
    
#19. Display Top 3 Empnames based on their Salary

SELECT ENAME AS `Emp Name`,SAL AS `Salary`FROM EMP
ORDER BY SAL DESC LIMIT 3;

#20. Display Empname who has highest Salary in Each Department.

SELECT ENAME AS `Emp Name`,DEPTNO AS `Department`,SAL AS `Salary`
FROM (SELECT ENAME,DEPTNO,SAL,RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) AS sal_rank
FROM EMP) AS ranked_emp WHERE sal_rank = 1;





