provider "aws" {
    region = "us-east-1"
}
terraform{
    backend "s3"{
        bucket = "ddavliev-terraform-demo" 
        key = "state/prod/tf.state"
        region = "us-east-1"
    }
}

variable "env" {
    default = "dev"
}

variable "ami_id" {
  type = map
  default = {
      "ubuntu18" = "ami-0ac80df6eff0e70b5"
      "centos8" = "ami-01ca03df4a6012157"
    }
}

resource "aws_key_pair" "mac13" {
    key_name = "mac13"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDcw3vBWsQTtaalUXpW4aqCueyf+l9jBV/q1SiUM35xW2nBuDhEq1nlYot/93iW9/wNTD1tUiHUFQYRnh9k8y27x/q8nlKTKYdOmLbyTTzBZRDhPS6uDYDbMIybM+LztTIhc17KusC6S+AzOGQCxHQzugAUHLff0QJymuditNCIzCasxd1puvhtmu27Dowb2QYncDlEGnxty9/olwb1SR0TnlrmMj8Z6RYAi+SQWX2V7QTFq9IxFfixO6x4w2JEMd7PaPrjl4KCEbXheGwOArsXvVtgdWw3vzxkvkR07LuCJziXhghPDdAKF6IjeAinjfvV5rQ2EG+qfJjdLqb5aTLnYBwJR2BEy6cl3+k4rj+yXMEDnpliqpCDvr7e96V3oAhC5+QudxYJag+ufXypv7JefiQ3Bj06SJKpmC3twDCotSTREioX3Ju93NkpkoDaIiBU6uIbVriiivR6juPe19BNpeo+QGTx3X1bNGB3yWgKk3n0wwDkj6O876NbwuRhpHM= mac13"
}


resource "aws_instance" "db" {
  ami           = var.ami_id["ubuntu18"]
  instance_type = "t1.micro"
  key_name      = aws_key_pair.mac13.key_name
  security_groups = [
      #"default",
      "SSH+HTTP"]
  tags = {
    Name = "${var.env}-db"
  }
}

resource "aws_instance" "web1" {
  ami           = var.ami_id["ubuntu18"]
  instance_type = "t1.micro"
  key_name = aws_key_pair.mac13.key_name
  security_groups = [
      "default",
      "SSH+HTTP"]
  tags = {
    Name = "${var.env}-web1"
  }
}

resource "aws_instance" "web2" {
  ami           = var.ami_id["ubuntu18"]
  instance_type = "t1.micro"
  key_name = aws_key_pair.mac13.key_name
  security_groups = [
      "default",
      "SSH+HTTP"]
  tags = {
    Name = "${var.env}-web2"
  }
}

output "db_hostname" {
    value = aws_instance.db.public_dns
}

output "web1_hostname" {
    value = aws_instance.web1.public_dns
}

output "web2_hostname" {
    value = aws_instance.web2.public_dns
}