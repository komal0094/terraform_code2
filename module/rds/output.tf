output "db-instance" {
  
  value = aws_db_instance.database1.address
}

output "username" {
    value = aws_db_instance.database1.username 
  
}

output "password" {
    value = aws_db_instance.database1.password
  
}

output "dbname" {
    value = aws_db_instance.database1.name  
  
}