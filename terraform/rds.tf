//resource "aws_db_instance" "rds" {
//    allocated_storage = 20
//    engine = "mysql"
//    db_name = "rds"
//    instance_class = "db.t3.micro"
//    username = "admin"
//    password = "root"
//    //db_subnet_group_name = aws_db_subnet_group.db_group.name
//    publicly_accessible = false
//    skip_final_snapshot = true
//
//}

//resource "aws_db_subnet_group" "db_group" {
//    name = "db-group"
//    subnet_ids = [aws_subnet.private.id]
//}