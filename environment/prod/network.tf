module "vpc" {
  source = "github.com/jetbrains-infra/terraform-aws-vpc?ref=v0.3.1" // https://github.com/jetbrains-infra/terraform-aws-vpc/releases/latest
  name   = "Project${title(local.stack)}"
  tags   = {}
}

module "internet_gateway" {
  source = "github.com/jetbrains-infra/terraform-aws-igw?ref=v0.3.0" // https://github.com/jetbrains-infra/terraform-aws-igw/releases/latest
  vpc_id = module.vpc.id
  tags   = {}
}

module "subnet_public_1" {
  source      = "github.com/jetbrains-infra/terraform-aws-routed-subnet?ref=v0.5.1" // https://github.com/jetbrains-infra/terraform-aws-routed-subnet/releases/latest
  name        = "Public #1"
  zone        = "eu-west-1b"
  subnet_cidr = cidrsubnet(module.vpc.cidr, 2, 0)
  type        = "public"
  route_table = module.internet_gateway.route_table_id
  tags        = {}
}

module "subnet_public_2" {
  source      = "github.com/jetbrains-infra/terraform-aws-routed-subnet?ref=v0.5.1" // https://github.com/jetbrains-infra/terraform-aws-routed-subnet/releases/latest
  name        = "Public #2"
  zone        = "eu-west-1c"
  subnet_cidr = cidrsubnet(module.vpc.cidr, 2, 1)
  type        = "public"
  route_table = module.internet_gateway.route_table_id
  tags        = {}
}

resource "aws_subnet" "db1" {
  vpc_id            = module.vpc.id
  cidr_block        = cidrsubnet(module.vpc.cidr, 2, 2)
  availability_zone = "eu-west-1c"
}

resource "aws_subnet" "db2" {
  vpc_id            = module.vpc.id
  cidr_block        = cidrsubnet(module.vpc.cidr, 2, 3)
  availability_zone = "eu-west-1b"
}
