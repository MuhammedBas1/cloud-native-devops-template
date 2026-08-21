resource "aws_iam_role" "web_role" {
    name = "web-ec2-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = "sts:AssumeRole"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_policy" "dynamodb_access" {
    name = "dynamodb-access"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{ 
            Effect = "Allow"
            Resource = aws_dynamodb_table.users.arn
            Action = [
                "dynamodb:GetItem",
                "dynamodb:PutItem",
            ]
        }]
    })
}


resource "aws_iam_role_policy_attachment" "attach" {
    role = aws_iam_role.web_role.id
    policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_iam_instance_profile" "web_profile" {
    name = "web_profile"
    role = aws_iam_role.web_role.name
}