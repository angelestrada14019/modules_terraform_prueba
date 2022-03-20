provider "aws" {
  region = "us-east-1" 
}
resource "aws_security_group" "ssh_conection" { #nombre del recurso que se esta creando, la funcion
    name= var.sg_name    
  
#   ingress {
#      # TLS (change to whatever ports you need)
#     from_port=443
#    to_port=443
#     protocol ="-1"    
#     cidr_blocks = [""]
#   }
  dynamic "ingress"{
    for_each = var.ingres_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress"{
    for_each = var.egress_rules
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
#   egress {
#    from_port=0
#    to_port=0
#     protocol ="-1"
#     cidr_blocks ="[0.0.0.0/0]"
#     prefix_list_ids=["pl-12c4e678 "]
    
#     }
}
resource "aws_instance" "practica1_ajea14019" {   
    ami=var.ami_id
    instance_type = var.instance
    tags=var.tags 
    key_name = var.key_pair
    security_groups = [aws_security_group.ssh_conection.name]
}



