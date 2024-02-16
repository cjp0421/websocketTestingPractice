# websocketTestingPractice
practicing with websockets and (hopefully) testing

Potentially Helpful Resources
https://quii.gitbook.io/learn-go-with-tests/build-an-application/websockets
https://spacelift.io/blog/terraform-gitignore

## Current Setup steps:
1. Configuring LocalStack container
    - create container from LocalStack:Pro image
    - 'expose' ports (find the port in the configuration list and set the local port with the same value)
      - 4510
      - 4566
    - set environment variables
      - LOCALSTACK_AUTH_TOKEN
        - <token value>
      - DISABLE_CORS_CHECKS
        - 1
      - DISABLE_CUSTOM_CORS_APIGATEWAY
        - 1
      - DEBUG
        - 1
    - [mount volume](https://hashnode.localstack.cloud/mounting-the-docker-socket)
      - /var/run/docker.sock
        - /var/run/docker.sock
1. Run `setup_mock_lambda.sh` to build/zip lambda
1. In `lambda.tf`, replace the commented source with the actual value
1. In the terminal, run:
    ```bash
    $ terraform init # pull in module
    $ terraform apply
    ```
    and follow the prompts 🚀