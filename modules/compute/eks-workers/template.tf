data "template_file" "worker_node_user_data_template" {
  template = file("${path.module}/scripts/user_data.sh")

  vars = {
    cluster_ca        = "${var.cluster_ca}"
    cluster_endpoint  = "${var.cluster_endpoint}"
    cluster_full_name = "${var.cluster_full_name}"
  }
}