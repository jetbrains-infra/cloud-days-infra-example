locals {
  // it's a good idea to define container_definition using hcl
  container_definition = {
    name      = local.service,
    hostname  = local.instance_name,
    memory    = local.mem,
    cpu       = local.cpu,
    essential = true,
    portMappings = [
      {
        hostPort      = 0,
        containerPort = local.app_port,
        protocol      = "tcp"
      }
    ],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = "/jetbrains/${local.stack}/${local.service}/${local.instance_name}",
        awslogs-region        = local.region
        awslogs-stream-prefix = "service-${local.build}-"
      }
    },
    mountPoints = [
      {
        containerPath = "/dumps"
        sourceVolume  = "dumps"
      }
    ],
    secrets = [
      {
        name      = "DYNAMODB_TABLE_NAME"
        valueFrom = "arn:aws:ssm:${local.region}:${local.account_id}:parameter/project/${local.stack}/settings/dynamodb/table"
      },
      {
        name      = "READ_STREAM_NAME"
        valueFrom = "arn:aws:ssm:${local.region}:${local.account_id}:parameter/project/${local.stack}/settings/kinesis/source/stream_name"
      },
      {
        name      = "WRITE_STREAM_NAME",
        valueFrom = "arn:aws:ssm:${local.region}:${local.account_id}:parameter/project/${local.stack}/settings/kinesis/target/stream_name"
      }
    ],
    environment = [
      {
        name  = "AWS_REGION"
        value = local.region
      }
    ],
    image = "${local.app_image}:${local.build}"
    repositoryCredentials = {
      credentialsParameter = local.docker_credentials
    }
  }
}
