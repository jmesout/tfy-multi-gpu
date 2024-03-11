

resource "kubernetes_daemonset" "nvidia-device-plugin-daemonset" {
  metadata {
    name      = "nvidia-device-plugin-daemonset"
    namespace = "kube-system"
  }

  spec {
    selector {
      match_labels = {
        name = "nvidia-device-plugin-ds"
      }
    }

    template {
      metadata {
        labels = {
          name = "nvidia-device-plugin-ds"
        }
      }

      spec {
        toleration {
          key      = "nvidia.com/gpu"
          operator = "Exists"
          effect   = "NoSchedule"
        }

        priority_class_name = "system-node-critical"

        container {
          image = "nvcr.io/nvidia/k8s-device-plugin:v0.14.5"
          name  = "nvidia-device-plugin-ctr"

          env {
            name  = "FAIL_ON_INIT_ERROR"
            value = "false"
          }

          env {
            name  = "DEVICE_LIST_STRATEGY"
            value = "volume-mounts"
          }

          env {
            name  = "DEVICE_ID_STRATEGY"
            value = "index"
          }

          security_context {
            allow_privilege_escalation = false
            capabilities {
              drop = ["ALL"]
            }
          }

          volume_mount {
            name       = "device-plugin"
            mount_path = "/var/lib/kubelet/device-plugins"
          }
        }

        volume {
          name = "device-plugin"

          host_path {
            path = "/var/lib/kubelet/device-plugins"
          }
        }
      }
    }
  }
}
