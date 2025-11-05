data "aws_subnet" "public_subnet" {
  filter {
    name = "tag:Name"
    values = ["Subnet-Public : Public Subnet 1"]
  }

  depends_on = [
    aws_route_table_association.public_subnet_asso
  ]
}

resource "aws_instance" "ec2_example" {
  ami = "ami-004e960cde33f9146"
  instance_type = "t2.micro"
  count = 2
  #key_name = aws_key_pair.deployer
  tags = {
    Name = "Web-app-${count.index + 1}"
  }
  subnet_id = data.aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.sg_vpc_jhooq_eu_central_1.id]
}




/*output "fetched_info_from_aws" {
  value = format("%s%s","ssh -i /Users/shubham/.ssh/aws_ec2_terraform ubuntu@",aws_instance.ec2_example.public_dns)
}*/

output "fetched_info_from_aws" {
  value = [
    for instance in aws_instance.ec2_example :
    format("ssh -i /Users/shubham/.ssh/aws_ec2_terraform ubuntu@%s", instance.public_dns)
  ]
}
