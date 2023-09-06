resource "kubernetes_deployment" "customer-deployment" {
  metadata {
    name = "customer-deployment"
    namespace = "nuvolar"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "customer"
      }
    }
    template {
      metadata {
        labels = {
          app = "customer"
        }
      }
      spec {
        container {
          image = "nuvolar/customer-service"
          name  = "customer-deployment"
          resources {
            limits = {
                memory = "512Mi"
                cpu = "500m"
            }
          }
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "order-deployment" {
  metadata {
    name = "order-deployment"
    namespace = "nuvolar"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "order"
      }
    }
    template {
      metadata {
        labels = {
          app = "order"
        }
      }
      spec {
        container {
          image = "nuvolar/order-service"
          name  = "order-deployment"
          resources {
            limits = {
                memory = "512Mi"
                cpu = "500m"
            }
          }
          env {
            name = "CUSTOMER_SERVICE_URL"
            value = "http://customer-service:8082"
          }
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "api-gateway-deployment" {
  metadata {
    name = "api-gateway-deployment"
    namespace = "nuvolar"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "api-gateway"
      }
    }
    template {
      metadata {
        labels = {
          app = "api-gateway"
        }
      }
      spec {
        container {
          image = "nuvolar/api-gateway"
          name  = "api-gateway"
          resources {
            limits = {
                memory = "512Mi"
                cpu = "500m"
            }
          }
          env {
            name = "ORDER_SERVICE_URL"
            value = "http://order-service:8081"
          }
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}