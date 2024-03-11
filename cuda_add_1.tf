resource "kubernetes_pod" "vector_add_1" {
  metadata {
    name      = "cuda-vector-add-1"
    namespace = "default" # Adjust this as necessary
  }

  spec {
    container {
      name  = "cuda-vector-add"
      image = "k8s.gcr.io/cuda-vector-add:v0.1"

      resources {
        limits = {
          "nvidia.com/gpu" = 1
        }
      }
    }
  }
}
