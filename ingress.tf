resource "kubernetes_ingress_v1" "api-gateway-ingress" {
  metadata {
    name = "api-gateway-ingress"
    namespace = "nuvolar"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target"  = "/"
      "cert-manager.io/cluster-issuer"              = "letsencrypt-prod"
    }
  }

  spec {
    rule {
      host = "test.com"

      http {
        path {
          backend {
            service {
              name = "api-gateway-service"
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
  }
  depends_on = [ kubernetes_service.api-gateway-service ]
}