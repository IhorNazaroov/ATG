resource "aws_instance" "ec2_instance" {
  count                = var.node_count
  ami                  = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.ami_key_pair_name
  iam_instance_profile = var.iam_role
  disable_api_termination = true
  root_block_device {
    delete_on_termination = true
  }
  user_data = <<EOF
#!/bin/bash
crontab -u root /fsx/maintenance/cron/${lower(var.client_name)}${count.index + 1}
sudo hostnamectl set-hostname ${lower(var.client_name)}${count.index + 1}
sudo mkdir /${lower(var.client_name)}
echo "${var.fsx_hostname}:/${lower(var.client_name)}  /${lower(var.client_name)}      nfs     nfsvers=4.1,defaults    0       0" >> /etc/fstab
sudo mount -a 
sudo ln -s /${lower(var.client_name)}/atg/${lower(var.client_name)}${count.index + 1} /opt/atg
sudo ln -s /${lower(var.client_name)}/atgdev/${lower(var.client_name)}${count.index + 1} /opt/atgdev
sudo chown -R atg:atg /opt/atg
sudo chown -R atg:atg /opt/atgdev
echo "After=${lower(var.client_name)}.mount" >> /etc/systemd/system/atg.service
echo "After=${lower(var.client_name)}.mount" >> /etc/systemd/system/atgdev.service
sudo systemctl daemon-reload
sudo systemctl restart atg
sudo systemctl restart atgdev
${var.client_user_data}
EOF

  network_interface {
    network_interface_id = aws_network_interface.internal_ip[count.index].id
    device_index         = 0
  }

  tags = {
    Server     = "${var.client_name}${count.index + 1}-${var.env}"
    AWS_Backup = "True"
    Name       = "${var.client_name}${count.index + 1}-${var.env}"
    Client     = "${var.client_name}-${var.env}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  count               = var.node_count
  alarm_name          = "CPUUsageAlarm_${lower(var.client_name)}${count.index + 1}-${var.env}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Alarm when CPU usage is >= 80%"
  alarm_actions       = ["${var.alarm_sns}"]
  dimensions = {
    InstanceId = aws_instance.ec2_instance.*.id[count.index]
  }
}

resource "aws_network_interface" "internal_ip" {
  count               = var.node_count
  subnet_id           = var.subnet_id[count.index]
  private_ips         = [ var.internal_ips[count.index]]
  security_groups     = var.security_group_ids
}
