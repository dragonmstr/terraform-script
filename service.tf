resource "kubernetes_service" "customer-service" {
  metadata {
    name = "customer-service"
    namespace = "nuvolar"
  }

  spec {
    selector = {
      app = "customer"
    }

    port {
      protocol = "TCP"
      port = 8082
      target_port = 8080
    }
  }
}

resource "kubernetes_service" "order-service" {
  metadata {
    name = "order-service"
    namespace = "nuvolar"
  }

  spec {
    selector = {
      app = "order"
    }

    port {
      protocol = "TCP"
      port = 8081
      target_port = 8080
    }
  }
}

resource "kubernetes_service" "api-gateway-service" {
  metadata {
    name = "api-gateway-service"
    namespace = "nuvolar"
  }

  spec {
    selector = {
      app = "api-gateway"
    }

    port {
      protocol = "TCP"
      port = 80
      target_port = 8080
      node_port = 31016
    }
    type = "NodePort"
  }
}

