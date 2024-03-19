locals {
  secure_mesh_site_data = {
    name = var.f5xc_cluster_name
    json = jsonencode(
      {
        metadata : {
          name : var.f5xc_cluster_name
          labels : var.f5xc_cluster_labels,
          namespace : var.f5xc_namespace,
        },
        disable : false
        annotations : {},
        spec : {
          volterra_certified_hw : var.f5xc_site_type_certified_hw[var.f5xc_ce_gateway_type],
          master_node_configuration : [
            for node in var.f5xc_nodes : {
              name : node.name
            }
          ],
          worker_nodes : [],
          no_bond_devices : {},
          default_network_config : {},
          coordinates : {
            latitude : var.f5xc_cluster_latitude,
            longitude : var.f5xc_cluster_longitude,
          },
          logs_streaming_disabled : {},
          default_blocked_services : {},
          offline_survivability_mode : var.f5xc_enable_offline_survivability_mode ? {
            enable_offline_survivability_mode : {}
          } : {
            no_offline_survivability_mode : {}
          },
          performance_enhancement_mode : var.f5xc_ce_performance_enhancement_mode.perf_mode_l7_enhanced ? {
            perf_mode_l7_enhanced : {}
          } : {
            perf_mode_l3_enhanced : {
              jumbo : var.f5xc_ce_performance_enhancement_mode.perf_mode_l3_enhanced.jumbo_frame_enabled ? {
                jumbo : {}
              } : {
                no_jumbo : {}
              }
            }
          }
        }
      }
    )
  }
}