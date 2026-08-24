output "bucket_arn" {
  description = "ARN des S3 Buckets"
  value       = aws_s3_bucket.portfolio_bucket.arn
}

//output "instance_public_ip" {
//    description = "Public-IP des Ec2 Instanzes"
//    value = aws_instance.web.public_ip
//}

output "alb_dns" {
  description = "Dns Server des Load-Balancers"
  value       = aws_lb.alb.dns_name
}

    