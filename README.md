# DS App SiteManager POC

This is a proof-of-concept repository to test self-hosted GitHub Actions runners for the DigiStratum ecosystem.

## Purpose

This repository is created as part of issue #1345 to validate self-hosted runner integration with ds-app-sitemanager workflows.

## CI Pipeline

The GitHub Actions workflow simulates the typical DigiStratum application CI pipeline:
- Security scanning
- Backend lint/test/build  
- Frontend lint/test/build
- E2E tests
- CDK synthesis

## Self-hosted Runner POC

This POC aims to:
1. Set up a self-hosted runner on a chosen platform
2. Register the runner with DigiStratum GitHub org
3. Configure runner labels for selective targeting
4. Modify one job to use the self-hosted runner
5. Monitor performance and collect metrics for 1 week
6. Compare performance vs GitHub-hosted runners

## Metrics to Collect

- Job execution time
- Success rate
- Resource usage
- Cost comparison
- Security incidents (if any)