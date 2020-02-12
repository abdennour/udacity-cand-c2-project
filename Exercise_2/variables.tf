# TODO: Define the variable for aws_region
# default values of VARS are populated by .env file, forwarded by docker-compose
variable "region" {}
# reference to Cloud credentials - default value comes from .env file
variable "aws_profile" {}