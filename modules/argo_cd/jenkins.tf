resource "helm_release" "argo_cd" {
  name             = "argo-cd"
  namespace        = var.namespace
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.46.4"
  create_namespace = true

  set {
    name  = "server.extraArgs[0]"
    value = "--insecure"
  }
}

resource "helm_release" "argo_apps" {
  name             = "argo-cd-apps"
  chart            = "${path.module}/charts"
  namespace        = var.namespace
  create_namespace = false

  depends_on = [helm_release.argo_cd]
}
