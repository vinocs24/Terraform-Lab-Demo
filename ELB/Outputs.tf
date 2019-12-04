output "elb_dns" {
    value = [aws_elb.terra.dns_name]
}
