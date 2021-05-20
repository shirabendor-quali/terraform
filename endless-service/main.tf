terraform {
  required_version = "> 0.8.0"
}

resource "null_resource" "test_me" {

 provisioner "local-exec" {

    command = "echo 'hello'; sleep 5h; echo 'world'"
  }
}
