resource "aws_autoscaling_group" "k3s_servers_asg" {
  name                      = "k3s_servers"
  wait_for_capacity_timeout = "5m"
  vpc_zone_identifier       = var.vpc_subnets

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]
  }

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 80 # change this to 100 if require that all the EC2 are on-demand
      spot_allocation_strategy                 = "capacity-optimized"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.k3s_server.id
        version            = "$Latest"
      }

      override {
        instance_type     = "t2.small"
        weighted_capacity = "1"
      }

      override {
        instance_type     = "t2.medium"
        weighted_capacity = "1"
      }

      override {
        instance_type     = "t3.small"
        weighted_capacity = "1"
      }

      override {
        instance_type     = "t3.medium"
        weighted_capacity = "1"
      }
    }
  }

  desired_capacity          = 3
  min_size                  = 3
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "k3s-server"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = ""
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
    value               = ""
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "k3s_workers_asg" {
  name                = "k3s_workers"
  vpc_zone_identifier = var.vpc_subnets

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 80 # change this to 100 if require that all the EC2 are on-demand
      spot_allocation_strategy                 = "capacity-optimized"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.k3s_agent.id
        version            = "$Latest"
      }

      override {
        instance_type     = "t2.small"
        weighted_capacity = "1"
      }

      override {
        instance_type     = "t2.medium"
        weighted_capacity = "1"
      }

      override {
        instance_type     = "t3.small"
        weighted_capacity = "1"
      }

      override {
        instance_type     = "t3.medium"
        weighted_capacity = "1"
      }
    }
  }

  desired_capacity          = 3
  min_size                  = 3
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "k3s-worker"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = ""
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
    value               = ""
    propagate_at_launch = true
  }
}
