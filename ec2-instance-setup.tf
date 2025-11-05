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

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDpa9rzBWqZ8ecRkDvDJa84WMe9UaxaPmb5IO3OQ7ewKIPqug53rAse/wSUT1QwPLHGraKKkKx26NOiX7KMxRLNLgVgrHVWtNDXZ5eKuDgP2+6DJMeWlKgdiQhalzhbNvkSAGTUvrUehKyNcjdD70UGK8hW8ckL+8W0oV59bhcoqhQkjN0OvDgGzxiY+n1PuSTMNui9bRTNrrUGogWSyjyE1F/t5NfwMT5Qi+Erxky5Jf81AXEQuPpgl08v9rtGxIS0rfDXxxhdHtdAs7CHjvF5g2ppPP4eLa2zR/qThK9ncWapT7v/vKBz6sTSLkXky08n3eqbjMeRdAg7jBzhWWy5 shubham@Shubhams-MacBook-Air.local"
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
