import pyspark.sql.functions as fn
from pyspark.sql import SparkSession

spark = (
    SparkSession.builder.appName("ExerciseSpark")
    .getOrCreate()
)

# Ler os dados no enem 2020
enem = (
        spark
        .read
        .format("csv")
        .option("header", True)
        .option("inferSchema", True)
        .option("delimiter", ";")
        .load("s3://datalake-lucas.andrade/raw_data/")
    )
    
# Escrever no DataLake em parquet
(
    enem
    .write
    .mode("overwrite")
    .format("parquet")
    .partitionBy("NU_ANO")
    .save("s3://datalake-lucas.andrade/consumer_zone/")
)