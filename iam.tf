resource "aws_iam_policy_attachment" "ssmmanagedpolicy_attach" {
  name       = "SSMManagedInstanceCore-attachment"
  roles      = [aws_iam_role.appliancerole.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "appliancerole_policy" {
  name = "appliancerole_policy"
  role = aws_iam_role.appliancerole.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssmmessages:*",
          "ssm:UpdateInstanceInformation",
          "ec2messages:*",
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "autoscaling:DescribeTags",
          "ec2:DescribeLaunchTemplateVersions"
        ],
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "appliancerole" {
  name = "SpecificRoutingDemo-SpecificRoutingAppliance"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  #   tags = local.common_tags
}

resource "aws_iam_instance_profile" "applianceprofile" {
  name = "applianceprofile"
  role = aws_iam_role.appliancerole.id
}