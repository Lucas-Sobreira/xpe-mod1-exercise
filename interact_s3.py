import boto3
import pandas as pd 

# Criar um cliente para interagir com o AWS S3
s3_client = boto3.client('s3')

# # Baixando arquivo do Bucket S3
# s3_client.download_file(
#     Bucket="datalake-lucas-andrade-igti-edc", 
#     Key="data/order_details.csv",
#     Filename="order_details.csv"
# )

# df = pd.read_csv('order_details.csv')
# print(df.head())

s3_client.upload_file("test.csv", 
                      "datalake-lucas-andrade-igti-edc",
                      "data/test.csv")