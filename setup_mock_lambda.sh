#! /bin/bash

# build mock lambda
GOARCH=arm64 GOOS=linux CGO_ENABLED=0 go build -tags lambda.norpc -o test_files/bootstrap test_files/main.go

# zip mock lambda executable into root
zip --junk-paths main.zip test_files/bootstrap
