# HCL - Hashicorp Configuration Language
# Linguagem declarativa

# link para consulta: https://registry.terraform.io/providers/hashicorp/aws/3.36.0/docs/resources/s3_bucket

# resource <ferramenta na AWS> <nome para ser refenciado>
resource "aws_s3_bucket" "datalake" {
  # Parâmetros de configuração do recurso escolhido
  bucket = "${var.base_bucket_name}-${var.ambiente}-${var.numero_conta}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"   # modo de encriptação
      }
    }
  }

  tags = {
    IES   = "IGTI",
    CURSO = "EDC"
  }
}

resource "aws_s3_bucket_object" "codigo_spark" {
  bucket = aws_s3_bucket.datalake.id
  key    = "emr-code/pyspark/job_spark_from_tf.py"
  acl    = "private"
  source = "../job_spark.py"
  etag   = filemd5("../job_spark.py") # Verifica se houve mudança no código spark
}

provider "aws" {
  region = "${var.region}"
}

# Centralizar o arquivo de controle de estado do terraform
terraform {
  backend "s3" {
    bucket = "terraform-state-lucas-igti"
    key = "state/igti/edc/mod1/terraform.tfstate"
    region = "us-east-2"
  }
}