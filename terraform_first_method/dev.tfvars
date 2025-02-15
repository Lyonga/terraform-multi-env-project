vpc_cidr_block    = "10.0.0.0/16"
subnet_cidr_block = "10.0.10.0/24"
avail_zone        = "us-east-1a"
env_prefix        = "dev"
my_ip             = "172.17.144.1/32"
instance_type     = "t2.micro"
key_name          = "server-key"
scp_content = jsonencode({
  Version = "2012-10-17",
  Statement = [
    {
      Effect = "Deny",
      Action = [
        "ec2:TerminateInstances",
        "ec2:DeleteVolume",
        "lambda:DeleteFunction"
      ],
      Resource = "*"
    }
  ]
})
