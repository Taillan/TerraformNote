resource "aws_key_pair" "citadel-key" {
  key_name = "citadel"
  public_key = file("/root/terraform-challenges/project-citadel/.ssh/ec2-connect-key.pub")
}


resource "aws_eip" "eip" {
  vpc = true
  instance = aws_instance.citadel.id
  provisioner "local-exec" {
    command = "echo ${self.public_dns}>>/root/citadel_public_dns.txt"
  }
}

resource "aws_instance" "citadel" {
  ami = var.ami
  instance_type = var.instance_type
  user_data = file("./install-nginx.sh")
}