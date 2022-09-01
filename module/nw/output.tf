# output "az" {
#     value = data.aws_availability_zones.available.names
  
# }
# output "pub-subnet" {

#     value = aws_subnet.pub-snet1.*.id
  
# }

output "vpc_id" {
    value = aws_vpc.my-vpc001.id
  
}
output "pub-snet-id" {
    value = aws_subnet.pub-subnet
}

