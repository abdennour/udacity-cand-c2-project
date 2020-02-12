data "archive_file" "lambda_zip_file_greeting" {
  type        = "zip"
  output_path = "/tmp/lambda_zip_file_greeting.zip"
  source {
    content  = file("greet_lambda.py")
    filename = "greet_lambda.py"
  }
  # in case of many .py files, zip their whole directory 
  # and use "source_dir" instead of "source". e.g: source_dir="Exercise_2", output_path = "/tmp/....zip"
}

resource "aws_lambda_function" "lambda_file_greeting" {
  filename         = data.archive_file.lambda_zip_file_greeting.output_path
  source_code_hash = data.archive_file.lambda_zip_file_greeting.output_base64sha256
	function_name = "greet_lambda"
  role = aws_iam_role.lambda_exec_role.arn
  description = "Python Lambda Function Saying Greetings"
  handler = "greet_lambda.lambda_handler"
  runtime = "python3.7"
  environment {
    variables = {
      greeting = "Hello"
    }
  }

  depends_on    = ["aws_iam_role_policy_attachment.lambda_logs"]

}

resource "aws_iam_role" "lambda_exec_role" {
  name        = "lambda_exec"
  path        = "/"
  description = "Allows Lambda Function to call AWS services on your behalf."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name = "lambda_logging"
  path = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role = "${aws_iam_role.lambda_exec_role.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}