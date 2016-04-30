# AWS CLI on CoreOS

No, you can't install `aws-cli` on CoreOS.

Yes, you can run this container and call out to it.

## Problem

I wanted to pull container images from my Elastic Container Registry (ECR) into my CoreOS on EC2, but in an automated way.

  * Sure I could do it manually just fine.
  * I wanted to do it automatically.
  * AWS documentation offered no obvious solution beyond "use ECS" which has its own share of problems.

## Solution

Run a container within CoreOS that has the aws cli tools installed, and simply mount a volume from CoreOS that contains the necessary configuration. Run commands from within that.

## Instructions

### Build the container

```bash
docker build -t aws/cli .
```

### Configuration files

Make sure `~/.aws/config` and `~/.aws/credentials` exist in your CoreOS instance.

#### `~/.aws/config`

```
[default]
region = us-east-1
```

#### `~/.aws/credentials`

```
[default]
aws_access_key_id = AKIXXXXXXXXXXXXXXXXX
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### Run your commands within the container

```bash
docker run -it -v $HOME/.aws:/home/aws/.aws aws/cli <command> <args>
```

#### Examples

**List Buckets**

```bash
docker run -it -v $HOME/.aws:/home/aws/.aws aws/cli aws s3 ls
```

**Get ECR Login**

```bash
docker run -it -v $HOME/.aws:/home/aws/.aws aws/cli aws ecr get-login
```

**Use a named profile**

```bash
run -it -v $HOME/.aws:/home/aws/.aws aws/cli aws ecr get-login --profile groove
```

## See Also

  * https://www.linkedin.com/pulse/use-aws-cli-from-coreos-via-docker-easy-way-john-drago
