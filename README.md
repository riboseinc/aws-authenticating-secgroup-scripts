# aws-authenticating-secgroup-scripts

Scripts to use [terraform-aws-authenticating-secgroup](https://github.com/riboseinc/terraform-aws-authenticating-secgroup) (support [AWS Signature v4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html))

- `-method`: "http_method"
- `-awsprofile`: optional name of the aws profile in ~/.aws/credentials to extract access key & secret
- `-credentials`: optional aws keys "aws_access_key:aws_secret_key"
- `-url`: the "/connection" url deployed at Aws Api Gateway using module [terraform-aws-authenticating-secgroup](https://github.com/riboseinc/terraform-aws-authenticating-secgroup)
- `-body`: optional file containing the data to include in the request body

If `-credentials` is not supplied, the credentials will be extracted from `~/.aws/credentials`

### Sample usage

With credentials on command line:

```bash
bash invoke_it.sh \
    -method POST \
    -credentials AKIAI53HQ44Fxxx:Kmxk9K1iABKnemz0yd6ccxCxxx \
    -url https://xxx.execute-api.xxx.amazonaws.com/dev/connection \
    -body file.json
```

Using credentials from "default" profile of `~/.aws/credentials`

```bash
bash invoke_it.sh \
    -method POST \
    -url https://xxx.execute-api.xxx.amazonaws.com/dev/connection \
    -body file.json
```

Using credentials from "staging" profile of `~/.aws/credentials`

```bash
bash invoke_it.sh \
    -method POST \
    -awsprofile staging
    -url https://xxx.execute-api.xxx.amazonaws.com/dev/connection \
    -body file.json
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write your code **and tests**
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new pull request


## Authors

This script provided by [Ribose Inc.](https://www.ribose.com) (GitHub page: [Ribose Inc.](https://github.com/riboseinc))


## License

Full text: [Apache License](LICENSE)
