#AWs beanstalk application initialization
resource "aws_elastic_beanstalk_application" "javapp-bean-prod" {
  name = "javapp-bean-prod"
}