provider "aws" {
  region = "eu-west-1"
}

resource "null_resource" "lambda_zip" {
  provisioner "local-exec" {
    command = "curl -o ${path.root}/function.zip -L https://github.com/swampshed/meow/releases/download/v1.0.1/function.zip"
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}


module "lambda_function" {
  depends_on = [null_resource.lambda_zip]
  source = "terraform-aws-modules/lambda/aws"

  function_name = "opsy_popsy"
  description   = "Opsy Popsy"
  handler       = "bootstrap"
  runtime       = "provided.al2023"
  architectures = ["x86_64"]
  create_package         = false
  local_existing_package = "${path.root}/function.zip"
}