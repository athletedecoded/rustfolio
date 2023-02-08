# World Clock with AWS Lambda

**Project Repo:** [https://github.com/athletedecoded/rust-mlops](https://github.com/athletedecoded/rust-mlops/tree/main/worldclock)

## Useage

AWS Lambda function that takes a timezone code as request parameter and returns the local date and time. Currently supports AEST, EST, PST, MST. Defaults to UTC if blank request parameter.

**Example**

```
# request
{
  "tz_code": "AEST"
}

# response
{
  "req_id": "2b0d6b70-09d8-4a78-8180-e1abe33eb5fb",
  "msg": "It is 08 February 2023 6:33:39 AM in AEST"
}
```

## Developer Notes

**Configure AWS IAM Role**

1. Create an AWS IAM User policy with `AWSLambda_FullAccess` permissions
2. Configure your ~/.aws/credentials file with environment variables: `aws_access_key_id`, `aws_secret_access_key`, `aws_role_arn`. 

*Note: `aws_role_arn` is copied from the IAM user summary and is formatted as arn:aws:iam::<aws_acct>:user/<iam_user>*

**Install Cargo Lambda**

```
$ sudo apt-get install python3-venv
$ python3 -m venv ~/.venv
$ source ~/.venv/bin/activate
$ pip3 install cargo-lambda
```

**Activate .venv** 
```
$ source ~/.venv/bin/activate
```

**Build Binary**

*For x86_64*

```
$ make release
```

*For arm64*

```
$ make release-arm
```

**Invoke Lambda fxn**
```
$ make invoke
```

**Deploy to AWS Lambda**
```
$ make deploy
```

## References

* [AWS Lambda Rust Runtime](https://github.com/awslabs/aws-lambda-rust-runtime)
* [Rust Date and Time](https://rust-lang-nursery.github.io/rust-cookbook/datetime.html)
* [chrono-tz crate docs](https://crates.io/crates/chrono-tz)