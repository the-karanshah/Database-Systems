1) Make directory in hdfs
hdfs dfs -mkdir /cse532

hdfs dfs -mkdir /cse532/input

2) copy csv to hdfs
hdfs dfs -copyFromLocal C:\Users\Karan\Desktop\StonyBrook\sem2\ToDB\assignments\4\cse532\input\covid19_full_data.csv /cse532/input

hdfs dfs -ls /cse532/input

3) task 1 

i) using True parameter
hadoop jar hadoop-streaming-3.1.0.jar -input /cse532/input/covid19_full_data.csv -output /cse532/output1 -file Covid19_1_Mapper.py -mapper "python Covid19_1_Mapper.py True" -file Covid19_1_Reducer.py -reducer "python Covid19_1_Reducer.py"

ii) using False parameter
hadoop jar hadoop-streaming-3.1.0.jar -input /cse532/input/covid19_full_data.csv -output /cse532/output1 -file Covid19_1_Mapper.py -mapper "python Covid19_1_Mapper.py False" -file Covid19_1_Reducer.py -reducer "python Covid19_1_Reducer.py"

4) remove folder from hdfs
hadoop dfs -rmr /cse532/output1

5) task 2
hadoop jar hadoop-streaming-3.1.0.jar -input /cse532/input/covid19_full_data.csv -output /cse532/output2 -file Covid19_2_Mapper.py -mapper "python Covid19_2_Mapper.py 2020-02-01 2020-03-31" -file Covid19_2_Reducer.py -reducer "python Covid19_2_Reducer.py"

6) remove folder from hdfs
hadoop dfs -rmr /cse532/output2


7) create cache folder in hdfs
hdfs dfs -mkdir /cse532/cache

8) copy csv to hdfs
hdfs dfs -copyFromLocal C:\Users\Karan\Desktop\StonyBrook\sem2\ToDB\assignments\4\cse532\cache\populations.csv /cse532/cache

9) task 3
hadoop jar hadoop-streaming-3.1.0.jar -input /cse532/input/covid19_full_data.csv -output /cse532/output3 -file Covid19_3_Mapper.py -mapper "python Covid19_3_Mapper.py" -file Covid19_3_Reducer.py -reducer "python Covid19_3_Reducer.py" -file cse532/cache/populations.csv

10) remove folder from hdfs
hadoop dfs -rmr /cse532/output3



11) task 1 (extra credit)
hadoop dfs -rmr /cse532/output1
spark-submit SparkCovid19_1.py /cse532/input/covid19_full_data.csv 2020-01-01 2020-03-31 /cse532/output1/


12) task 2 (extra credit)
hadoop dfs -rmr /cse532/output2
spark-submit SparkCovid19_2.py /cse532/input/covid19_full_data.csv /cse532/cache/populations.csv /cse532/output2/


13) task 3 (extra credit)

task2
hadoop - 33.17 seconds
spark - 10.23 seconds

task3 
hadoop - 37.40 seconds
spark - 11.53 seconds