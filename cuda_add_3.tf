resource "kubernetes_pod" "vector_add_3" {
  metadata {
    name      = "cuda-vector-add-3"
    namespace = "default" # Adjust this as necessary
  }

  spec {
    container {
      name  = "cuda-vector-add"
      image = "k8s.gcr.io/cuda-vector-add:v0.1"
      lifecycle{
        post_start{
          exec{
            command = ["nvidia-smi"]
          }
        }
      }
      resources {
        limits = {
          "nvidia.com/gpu" = 2
        }
      }
    }
  }
}
