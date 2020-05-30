Q.1
>>javac SalaryStdDev.java
>>java  -cp "path2jdbcdriver.jar" SalaryStdDev databasename tablename login password

Q.2
>>db2 -td@ -f stddev.sql

note: I added employee table manually in schema CSE532 and so I had to use cse532.employee in stddev.sql to run in my system. However I have removed cse532 and kept only employee, which should run in others system.