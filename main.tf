resource "aws_apigatewayv2_api" "example" {
  name                       = "example-websocket-api"
  protocol_type              = "WEBSOCKET"
}

output "test" {
  value = aws_apigatewayv2_api.example.api_endpoint
}

resource "aws_apigatewayv2_route" "ws_messenger_api_connect_route" {
  api_id    = aws_apigatewayv2_api.example.id
  route_key = "$connect"
  target = "integrations/${aws_apigatewayv2_integration.example.id}"
  route_response_selection_expression = "$default"
}

resource "aws_apigatewayv2_integration" "example" {
  api_id           = aws_apigatewayv2_api.example.id
  integration_type = "MOCK"// we don't MOCK - AWS_PROXY insteadt  
}

resource "aws_apigatewayv2_stage" "example" {
  api_id = aws_apigatewayv2_api.example.id
  name   = "example-stage"
}

resource "aws_apigatewayv2_route_response" "example" {
  api_id             = aws_apigatewayv2_api.example.id
  route_id           = aws_apigatewayv2_route.ws_messenger_api_connect_route.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_integration_response" "connectIntegrationReponse" {
  api_id                   = aws_apigatewayv2_api.example.id
  integration_id           = aws_apigatewayv2_integration.example.id
  integration_response_key = "$default"
  template_selection_expression = "xxx"
  response_templates = {
    "$default" = "{ statusCode: 200 }"
    }
}

data "aws_iam_policy_document" "ws_lambda_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
  }
}

