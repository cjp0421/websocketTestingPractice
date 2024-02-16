resource "aws_apigatewayv2_api" "example" {
  name          = "example-websocket-api-2"
  protocol_type = "WEBSOCKET"

  route_selection_expression = "$request.body.action"
}


output "test" {
  value = aws_apigatewayv2_api.example.api_endpoint
}

output "websocket_url" {
  value = aws_apigatewayv2_stage.example.invoke_url
}

resource "aws_apigatewayv2_route" "ws_messenger_api_connect_route" {
  api_id    = aws_apigatewayv2_api.example.id
  route_key = "$connect"
  target    = "integrations/${aws_apigatewayv2_integration.example.id}"

  route_response_selection_expression = "$default"
}

resource "aws_apigatewayv2_integration" "example" {
  api_id             = aws_apigatewayv2_api.example.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  # integration_uri    = data.aws_lambda_function.existing.invoke_arn
  integration_uri = module.mock_lambda.lambda_function.invoke_arn
}

resource "aws_apigatewayv2_integration_response" "connectIntegrationReponse" {
  api_id                   = aws_apigatewayv2_api.example.id
  integration_id           = aws_apigatewayv2_integration.example.id
  integration_response_key = "$default"
}

# resource "aws_cloudwatch_log_group" "api_gateway_log_group" {
#   name = "API_GW_WEBSOCKET_TESING"

#   retention_in_days = 30
# }

# resource "aws_iam_role" "cloudwatch_exec" {
#   name = "test_cloudwatch_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = [
#         "sts:AssumeRole"
#       ]
#       Effect = "Allow"
#       Sid    = ""
#       Principal = {
#         Service = local.merged_services_allowed_to_assume_role
#       }
#       }
#     ]
#   })
# }

resource "aws_apigatewayv2_stage" "example" {
  api_id      = aws_apigatewayv2_api.example.id
  name        = "example-stage"
  auto_deploy = true

  # access_log_settings {
  #   destination_arn = aws_cloudwatch_log_group.api_gateway_log_group.arn
  #   format          = "{ \"requestId\" : \"$context.requestId\", \"ip\" : \"$context.identity.sourceIp\", \"requestTime\" : \"$context.requestTime\", \"httpMethod\" : \"$context.httpMethod\", \"routeKey\" : \"$context.routeKey\", \"status\" : \"$context.status\", \"protocol\" : \"$context.protocol\", \"responseLength\" : \"$context.responseLength\" }"
  # }
}

resource "aws_apigatewayv2_route_response" "example" {
  api_id             = aws_apigatewayv2_api.example.id
  route_id           = aws_apigatewayv2_route.ws_messenger_api_connect_route.id
  route_response_key = "$default"
}

# data "aws_lambda_function" "existing" {
#   function_name = "deleteMeWebsocketTest"
# }

# data "aws_iam_policy" "example" {
#   name = "AWSLambdaBasicExecutionRole-5e44d1d7-f127-4038-b0d0-f7f5b056fd2c"
# }

# data "aws_iam_role" "example" {
#   name = "deleteMeWebsocketTest-role-caqphxv2"
# }

# resource "aws_iam_role_policy_attachment" "lambda_policy" {
#   role       = data.aws_iam_role.example.name
#   policy_arn = data.aws_iam_policy.example.arn
# }

resource "aws_lambda_permission" "ws_messenger_lambda_permissions" {
  # statement_id  = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  # function_name = data.aws_lambda_function.existing.function_name
  function_name = module.mock_lambda.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.example.execution_arn}/*/*"
}

##########################
# set cloudwatch role for api gw
################################
# resource "aws_api_gateway_account" "demo" {
#   cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
# }

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["apigateway.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "cloudwatch" {
#   name               = "api_gateway_cloudwatch_global"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }
