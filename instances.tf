
resource "aws_instance" "rancher-preview-server" {
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${lookup(var.instance_type, var.region)}"
    subnet_id = "${aws_subnet.public.id}"
    key_name = "${aws_key_pair.dev.key_name}"
    vpc_security_group_ids = ["${aws_security_group.web.id}"]

    tags {
        Name = "rancher-preview-server"
        Group = "rancher-preview"
    }
}

resource "aws_eip" "eip_01" {
    vpc = true
    instance = "${aws_instance.rancher-preview-server.id}"
}

