resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = "ami-004e960cde33f9146"   # ✅ Replace with your AMI
  instance_type = "t2.micro"
  key_name      = "aws_key"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.sg_vpc_jhooq_eu_central_1.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-instance"
    }
  }

  user_data = base64encode(file("install.sh"))
}
