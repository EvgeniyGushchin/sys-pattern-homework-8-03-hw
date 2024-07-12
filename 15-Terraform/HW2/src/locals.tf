locals {
    web_name = "${var.vm_web_name}-${var.default_zone}-${var.vm_web_platform}"
    db_name  = "${var.vm_db_name}-${var.default_zone_db}-${var.vm_db_platform}"
}