resource "aws_ecr_repository" "app" {
  name = "${var.project}-app"

  # GitOps: image tags are immutable, traceable pointers (the git SHA).
  # IMMUTABLE prevents a tag from ever being overwritten, so the manifest
  # in the config repo always maps to exactly one build.
  image_tag_mutability = "IMMUTABLE"

  # Lets `terraform destroy` remove the repo even if it still holds images.
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}
