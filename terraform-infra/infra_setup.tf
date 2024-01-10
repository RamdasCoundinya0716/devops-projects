provider "aws" {
    access_key = "AKI************************"
    secret_key = "8u****************************"
    region = "ap-south-2"
}

# Creation of large instance
resource "aws_instance" "java-app" {
    instance_type = "t3.large"
    ami = "ami-0bbc2f7f6287d5ca6"
}

# Creation of Elastic IP
resource "aws_eip" "java-app-eip" {
    domain = "vpc"
}

# Association of Elastic IP with our instance
resource "aws_eip_association" "java_app_assoc" {
    instance_id = aws_instance.java-app.id
    allocation_id = aws_eip.java-app-eip.id
}

# Security Group Creation
resource "aws_security_group" "ramsg07" {
    name = "ramsg07"
    ingress {
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = [var.IP]
    }
    ingress {
        from_port        = 8080
        to_port          = 8080
        protocol         = "tcp"
        cidr_blocks      = [var.IP]
    }
    ingress {
        from_port        = 9000
        to_port          = 9000
        protocol         = "tcp"
        cidr_blocks      = [var.IP]
    }
}
