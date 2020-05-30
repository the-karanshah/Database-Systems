CREATE OR REPLACE PROCEDURE STD_DEV(
    OUT STD double
  )
  LANGUAGE SQL
  BEGIN

    DECLARE total_sq double DEFAULT 0;
    DECLARE total double DEFAULT 0;
    DECLARE temp integer DEFAULT 0;
    DECLARE CUR_END INT DEFAULT 0;
    DECLARE SALARY double;

    DECLARE CUR CURSOR FOR SELECT SALARY FROM CSE532.EMPLOYEE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET CUR_END = 1;
    OPEN CUR;
      FETCH CUR INTO SALARY;
      WHILE CUR_END = 0 DO
          SET temp=temp+1;
          SET total_sq=total_sq+SALARY*SALARY;
          SET total=total+SALARY;
          FETCH CUR INTO SALARY;
      END WHILE;
      SET STD=SQRT((total_sq/temp)-(total/temp)*(total/temp));
    CLOSE CUR;

  END@

CALL STD_DEV(?)@