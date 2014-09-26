CREATE TABLE COUNTRIES
(	
	COUNTRY_ID CHAR(2) CONSTRAINT "COUNTRY_ID_NN" NOT NULL, 
	COUNTRY_NAME VARCHAR(40), 
	REGION_ID INT, 
	OTHER TEXT, 
	CONSTRAINT COUNTRY_C_ID_PK PRIMARY KEY (COUNTRY_ID)
);

CREATE TABLE LOCATIONS 
(	
	LOCATION_ID INT CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID"), 
	STREET_ADDRESS VARCHAR(40), 
	POSTAL_CODE VARCHAR(12), 
	CITY VARCHAR(30) CONSTRAINT "LOC_CITY_NN" NOT NULL, 
	STATE_PROVINCE VARCHAR(25), 
	COUNTRY_ID CHAR(2) CONSTRAINT "LOC_C_ID_FK" FOREIGN KEY ("COUNTRY_ID") REFERENCES "COUNTRIES" ("COUNTRY_ID")
);

CREATE TABLE REGIONS
(	
	REGION_ID INT CONSTRAINT "REGION_ID_NN" NOT NULL, 
	REGION_NAME VARCHAR(25), 
	REGION_DESCRIPTION TEXT, 
    CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID")
);


CREATE TABLE DEPARTMENTS
(	
	 DEPARTMENT_ID INT, 
	 DEPARTMENT_NAME VARCHAR(30) CONSTRAINT "DEPT_NAME_NN" NOT NULL, 
	 MANAGER_ID INT, 
	 LOCATION_ID INT, 
	 CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID"), 
	 CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID") REFERENCES "LOCATIONS" ("LOCATION_ID"), 
);

CREATE TABLE JOBS
(	
	 JOB_ID VARCHAR(10) CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID"), 
	 JOB_TITLE VARCHAR(35) CONSTRAINT "JOB_TITLE_NN" NOT NULL, 
	 MIN_SALARY DECIMAL, 
	 MAX_SALARY DECIMAL, 
	 
);

CREATE TABLE EMPLOYEES
(	
    EMPLOYEE_ID INT, 
	FIRST_NAME VARCHAR(20), 
	LAST_NAME VARCHAR(25) CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL, 
	EMAIL VARCHAR(25) CONSTRAINT "EMP_EMAIL_NN" NOT NULL, 
	PHONE_NUMBER VARCHAR(20), 
	HIRE_DATE DATE CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL, 
	JOB_ID VARCHAR(10) CONSTRAINT "EMP_JOB_NN" NOT NULL, 
	SALARY DECIMAL, 
	COMMISSION_PCT DECIMAL, 
	MANAGER_ID INT, 
	DEPARTMENT_ID INT, 
	CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0), 
	CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL"), 
	CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID"), 
	CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID") REFERENCES DEPARTMENTS ("DEPARTMENT_ID"), 
	CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID") REFERENCES JOBS ("JOB_ID"), 
	CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID") REFERENCES EMPLOYEES ("EMPLOYEE_ID")
);

ALTER TABLE DEPARTMENTS ADD CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID")
 
CREATE TABLE JOB_HISTORY 
(	
	EMPLOYEE_ID int CONSTRAINT "JHIST_EMPLOYEE_NN" NOT NULL, 
	START_DATE DATE CONSTRAINT "JHIST_START_DATE_NN" NOT NULL, 
	END_DATE DATE CONSTRAINT "JHIST_END_DATE_NN" NOT NULL, 
	JOB_ID VARCHAR(10) CONSTRAINT "JHIST_JOB_NN" NOT NULL, 
	DEPARTMENT_ID int,
	CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date), 
	CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY (EMPLOYEE_ID, "START_DATE"),
	CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID), 
	CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY (EMPLOYEE_ID)REFERENCES EMPLOYEES (EMPLOYEE_ID), 
	CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID)
);