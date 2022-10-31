# resource "aws_route53_record" "redis" {
#   zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTEDZONE_ID
#   name    = "redis-${var.ENV}.data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTEDZONE_NAME"
#   type    = "CNAME"
#   ttl     = 10
#   records = [aws_elasticache_cluster.redis.cluster_address]
# }

output "redis-output" {
  value = aws_elasticache_cluster.redis
}