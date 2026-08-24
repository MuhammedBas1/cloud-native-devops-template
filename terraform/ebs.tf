//resource "aws_ebs_volume" "web_volume" {
//    availability_zone = "eu-central-1a"
//    size = 10
//    type = "gp3"
//}
//
//resource "aws_volume_attachment" "web_connect" {
//    volume_id = aws_ebs_volume.web_volume.id
//    instance_id = aws_instance.web.id
//    device_name = "/dev/sdf"
//}