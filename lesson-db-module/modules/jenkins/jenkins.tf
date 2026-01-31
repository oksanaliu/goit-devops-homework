resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = "jenkins"
  create_namespace = true

  values = [
    jsonencode({
      controller = {
        serviceType = "LoadBalancer"
      }
      serviceAccount = {
        create = true
        name   = "jenkins"
      }
    })
  ]
}
