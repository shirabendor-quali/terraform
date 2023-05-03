provider "aws" {
  region = var.aws_region
}


#TODO : create or update
resource "aws_apigatewayv2_api" "lambda_api" {
  name          = "lambda_api"
  protocol_type = "HTTP"
}

#TODO : create or update
resource "aws_apigatewayv2_stage" "lambda_api_stage" {
  api_id = aws_apigatewayv2_api.lambda_api.id

  name        = var.stage
  auto_deploy = true

}

resource "aws_apigatewayv2_integration" "lambda_api_integration" {
  api_id = aws_apigatewayv2_api.lambda_api.id

  integration_uri    = var.apis.url
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "lambda_api_route" {
  api_id = aws_apigatewayv2_api.lambda_api.id

  route_key = var.apis.path
  target    = "integrations/${aws_apigatewayv2_integration.lambda_api_integration.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_world.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}