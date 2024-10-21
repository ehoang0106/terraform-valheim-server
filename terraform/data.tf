data "local_file" "input_template" {
    filename = "${path.module}/valheim-install.tftpl"
}

data "template_file" "user_data" {
    template = data.local_file.input_template.content
    vars = {
        password = var.password
    }

}

