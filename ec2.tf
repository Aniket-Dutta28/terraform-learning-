resource "aws_key_pair" "keys" {
  key_name = "My-keys"
  public_key = ""
}

resource "aws_default_vpc" "defult_vpc" {
  
}

resource "aws_security_group" "security_group" {
    name="terra-security_group"
    description = "this security_group is made by terrafor and for my local to remote instace creatinog"
    vpc_id = aws_default_vpc.defult_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name="automate-sg"
    }
}

resource "aws_instance" "my-instace" {
        count = 3
    key_name = aws_key_pair.keys.key_name
    security_groups = [aws_security_group.security_group.name]
    ami = "ami-042b4708b1d05f512"
    instance_type = "t3.micro" 

    root_block_device {
      volume_size = 15
      volume_type = "gp3"
    }
    tags = {
        Name="ansible_server"
    }
}