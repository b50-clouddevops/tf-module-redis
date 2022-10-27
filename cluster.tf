# Creates Redis Cluster
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1                      # An ideal prod-cluster should have 3 nodes.
  parameter_group_name = aws_elasticache_parameter_group.default.name
  port                 = 6379
}

# Creates Parameter Group
resource "aws_elasticache_parameter_group" "default" {
  name   = "roboshop-redis-${var.ENV}"
  family = "redis6.2"
}

# Creates subnet Group
resource "aws_elasticache_subnet_group" "subnet-group" {
  name       = "roboshop-redis-${var.ENV}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}

# # Creates DocDB Cluster
# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "roboshop-${var.ENV}"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "roboshop1"
# # True only during lab, in prod , we will take a snapshot and that time value will be false
#   skip_final_snapshot     = true
#   db_subnet_group_name    = aws_docdb_subnet_group.docdb.name
# }


# # Creates Subnet Group
# resource "aws_docdb_subnet_group" "docdb" {
#   name       = "roboshop-mongo-${var.ENV}"
#   subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

#   tags = {
#     Name = "My docdb subnet group"
#   }
# }

# # Creats DocDB Cluster Instances and adds them to the cluster
# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "roboshop-${var.ENV}"
#   cluster_identifier = aws_docdb_cluster.docdb.id
#   instance_class     = "db.t3.medium"
# }
