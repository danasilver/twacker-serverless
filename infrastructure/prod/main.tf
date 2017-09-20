variable "aws_region" {}
variable "apex_function_hello" {}

resource "aws_api_gateway_method" "ResourceMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.TwackerAPIProd.id}"
  resource_id = "${aws_api_gateway_resource.stats.id}"
  http_method = "GET"
  authorization = "NONE"
  request_parameters = {}
  request_models = { "application/json" = "Empty" }
}

resource "aws_api_gateway_integration" "ResourceMethodIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.TwackerAPIProd.id}"
  resource_id = "${aws_api_gateway_resource.stats.id}"
  http_method = "${aws_api_gateway_method.ResourceMethod.http_method}"
  type = "AWS"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.apex_function_hello}/invocations"
  integration_http_method = "POST"
  credentials = "arn:aws:iam::061456065888:role/TwackerApiGatewayExecuteLambda"
  request_templates = { "application/json" = "#set($inputRoot = $input.path('$')){}" }
}

resource "aws_api_gateway_integration_response" "ResourceMethodIntegration200" {
  rest_api_id = "${aws_api_gateway_rest_api.TwackerAPIProd.id}"
  resource_id = "${aws_api_gateway_resource.stats.id}"
  http_method = "${aws_api_gateway_method.ResourceMethod.http_method}"
  status_code = "${aws_api_gateway_method_response.ResourceMethod200.status_code}"
  response_parameters = {}
  response_templates = { "application/json" = "$input.body"}
  depends_on = ["aws_api_gateway_integration.ResourceMethodIntegration"]
}

resource "aws_api_gateway_method_response" "ResourceMethod200" {
  rest_api_id = "${aws_api_gateway_rest_api.TwackerAPIProd.id}"
  resource_id = "${aws_api_gateway_resource.stats.id}"
  http_method = "${aws_api_gateway_method.ResourceMethod.http_method}"
  status_code = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {}
}

resource "aws_api_gateway_rest_api" "TwackerAPIProd" {
  name = "Twacker API - Prod"
  description = "Production API for Twacker"
}

resource "aws_api_gateway_resource" "stats" {
  rest_api_id = "${aws_api_gateway_rest_api.TwackerAPIProd.id}"
  parent_id = "${aws_api_gateway_rest_api.TwackerAPIProd.root_resource_id}"
  path_part = "stats"
}

resource "aws_api_gateway_deployment" "TwackerAPIDeploymentProd" {
  depends_on = [
    "aws_api_gateway_integration.ResourceMethodIntegration",
    "aws_api_gateway_integration_response.ResourceMethodIntegration200",
    "aws_api_gateway_method_response.ResourceMethod200",
    "aws_api_gateway_integration.ResourceMethodIntegration"
  ]
  rest_api_id = "${aws_api_gateway_rest_api.TwackerAPIProd.id}"
  stage_name = "prod"
}
