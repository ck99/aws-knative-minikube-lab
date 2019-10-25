resource "null_resource" "knative_custom_resource_definitions" {
  provisioner "local-exec" {
    command = <<EOS
${local.kubectl_cmd} apply --selector knative.dev/crd-install=true \
   --filename https://github.com/knative/serving/releases/download/v0.9.0/serving.yaml \
   --filename https://github.com/knative/eventing/releases/download/v0.9.0/release.yaml \
   --filename https://github.com/knative/serving/releases/download/v0.9.0/monitoring.yaml

EOS
    interpreter = ["/bin/sh", "-c"]
  }
  depends_on = [null_resource.istio_local_gateway]
}

resource "null_resource" "knative_install" {
  provisioner "local-exec" {
    command = <<EOS
${local.kubectl_cmd} apply \
   --filename https://github.com/knative/serving/releases/download/v0.9.0/serving.yaml \
   --filename https://github.com/knative/eventing/releases/download/v0.9.0/release.yaml \
   --filename https://github.com/knative/serving/releases/download/v0.9.0/monitoring.yaml

EOS
    interpreter = ["/bin/sh", "-c"]
  }
  depends_on = [null_resource.knative_custom_resource_definitions]
}