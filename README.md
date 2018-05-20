# aws-authenticating-secgroup-scripts

Scripts to use [terraform-aws-authenticating-secgroup](https://github.com/riboseinc/terraform-aws-authenticating-secgroup) (support [AWS Signature v4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html))

- `-method`: "http_method"
- `-credentials`: "aws_account_id:aws_access_key"
- `-url`: the "/connection" url deployed at Aws Api Gateway using module [terraform-aws-authenticating-secgroup](https://github.com/riboseinc/terraform-aws-authenticating-secgroup)


### Sample usage

```bash
bash invoke_it.sh \
    -method POST \
    -credentials AKIAI53HQ44Fxxx:Kmxk9K1iABKnemz0yd6ccxCxxx \
    -url https://xxx.execute-api.xxx.amazonaws.com/dev/connection
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
