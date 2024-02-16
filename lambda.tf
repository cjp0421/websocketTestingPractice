module "mock_lambda" {
  # source = "<replace me 🚀>"


  environment        = "testing"
  testing            = true
  lambda_zip         = "main.zip"
  lambda_name        = "example-websocket-lambda"
  lambda_handler     = "main"
  lambda_description = "test lambda for websocket testing"
  # lambda_environment_variables = module.organization_routes.lambda_environment_variables
  # services_allowed_to_assume_role = [
  #   "scheduler.amazonaws.com",
  # ]
  # policies_to_attach = [
  #   aws_iam_policy.invoke_test_lambda,
  # ]
}
