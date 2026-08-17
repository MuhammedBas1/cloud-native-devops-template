output "bucket_arn" {
  description = "ARN des S3 Buckets"
  value       = aws_s3_bucket.portfolio_bucket.arn
}