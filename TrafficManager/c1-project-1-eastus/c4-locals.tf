locals{
    //rgname = "${var.resource_group_name}-${var.Environment}"
    rgname = "${var.resource_group_location}-${var.business_unit}-${var.Environment}"
    //rgname = "${var.resource_group_location}-${var.Environment}"
    
    owner ="ShubhJ"
    common_tags={
        //service_name = local.service_name
        owner = local.owner
    }
}