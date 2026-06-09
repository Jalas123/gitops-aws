# gitops-aws

Learning project: a full GitOps pipeline on AWS.

## Flow

```
Developer → app repo → GitHub Actions (build/test/push) → ECR
                                    │
                                    └─ writes image tag → config repo
                                                              │
                                          Argo CD (in cluster) pulls & reconciles
```

GitOps rule: CI never touches the cluster. It builds an image, pushes to ECR,
and commits a new image tag to the config repo. Argo CD, running inside the
cluster, pulls that commit and reconciles reality to match git.

## Stack

| Concern   | Tool                                   |
|-----------|----------------------------------------|
| IaC       | Terraform (AWS provider)               |
| Cluster   | EKS  *(or k3s on EC2 — TBD)*            |
| Registry  | ECR                                    |
| CI        | GitHub Actions (auth via AWS OIDC)     |
| CD        | Argo CD                                |

## Phases

- [ ] **1. Infra** — Terraform provisions the cluster + ECR
- [ ] **2. App + CI** — app builds, tests, pushes image to ECR via OIDC
- [ ] **3. Manifests** — config repo with k8s manifests (the source of truth)
- [ ] **4. Argo CD** — installed in-cluster, watching the config repo
- [ ] **5. Close the loop** — CI bumps the image tag; Argo CD auto-deploys

## Layout

```
infra/    Terraform — cluster, networking, ECR
app/      sample application + Dockerfile + CI workflow   (phase 2)
config/   k8s manifests — usually a SEPARATE repo         (phase 3)
```

## Cost note

EKS control plane runs ~$0.10/hr (~$73/mo) and bills whether or not you use it.
Run `terraform destroy` when you stop for the day. k3s-on-EC2 avoids this fee.
