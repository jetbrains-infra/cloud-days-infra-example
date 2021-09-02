resource "aws_ecs_task_definition" "project" {
  family                = "${local.service}-${local.instance_name}-${local.stack}"
  container_definitions = jsonencode([local.container_definition])
  task_role_arn         = local.ecs_service_task_role_arn
  execution_role_arn    = local.ecs_task_execution_role_arn

  volume {
    name      = "dumps"
    host_path = "/tmp"
  }
}

data "aws_ecs_task_definition" "project" {
  task_definition = aws_ecs_task_definition.project.family
  depends_on      = [aws_ecs_task_definition.project]
}

resource "aws_ecs_service" "project" {
  name                               = "${local.service}-${local.instance_name}"
  cluster                            = local.ecs_cluster_arn
  desired_count                      = local.ecs_service_task_count
  iam_role                           = local.ecs_service_role_arn
  deployment_minimum_healthy_percent = local.minimum_healthy_percent
  deployment_maximum_percent         = local.maximum_percent
  task_definition                    = "${aws_ecs_task_definition.project.family}:${aws_ecs_task_definition.project.revision}"

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  capacity_provider_strategy {
    capacity_provider = local.ecs_capacity_provider_name
    base              = 0
    weight            = 1
  }

  load_balancer {
    container_name   = local.service
    container_port   = local.app_port
    target_group_arn = aws_alb_target_group.default.arn
  }

  deployment_controller {
    type = "ECS"
  }
}
