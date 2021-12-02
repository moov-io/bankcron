[![Moov Banner Logo](https://user-images.githubusercontent.com/20115216/104214617-885b3c80-53ec-11eb-8ce0-9fc745fb5bfc.png)](https://github.com/moov-io)

<p align="center">
  <a href="https://slack.moov.io/">Community</a>
  ·
  <a href="https://moov.io/blog/">Blog</a>
  <br>
  <br>
</p>

[![Build Status](https://github.com/moov-io/bankcron/workflows/Go/badge.svg)](https://github.com/moov-io/bankcron/actions)
[![Go Report Card](https://goreportcard.com/badge/github.com/moov-io/bankcron)](https://goreportcard.com/report/github.com/moov-io/bankcron)
[![Repo Size](https://img.shields.io/github/languages/code-size/moov-io/bankcron?label=project%20size)](https://github.com/moov-io/bankcron)
[![Apache 2 License](https://img.shields.io/badge/license-Apache2-blue.svg)](https://raw.githubusercontent.com/moov-io/bankcron/master/LICENSE)
[![Slack Channel](https://slack.moov.io/badge.svg?bg=e01563&fgColor=fffff)](https://slack.moov.io/)
[![Docker Pulls](https://img.shields.io/docker/pulls/moov/bankcron)](https://hub.docker.com/r/moov/bankcron)
[![GitHub Stars](https://img.shields.io/github/stars/moov-io/bankcron)](https://github.com/moov-io/bankcron)
[![Twitter](https://img.shields.io/twitter/follow/moov?style=social)](https://twitter.com/moov?lang=en)

# moov-io/bankcron
Moov's mission is to give developers an easy way to create and integrate bank processing into their own software products. Our open source projects are each focused on solving a single responsibility in financial services and designed around performance, scalability, and ease of use.

`bankcron` is a wrapper around typical bash/shell commands to only run them on banking days. This is useful for processes which should only run on days when federal banks are open.

## Table of contents

- [Project status](#project-status)
- [Usage](#usage)
- [Getting help](#getting-help)
- [Supported and tested platforms](#supported-and-tested-platforms)
- [Contributing](#contributing)

## Project status

bankcron is used in production at Moov. Please star the project if you are interested in its progress. If you have questions, issues or feature requests please open an issue or contact us.

## Usage

bankcron is designed to be used in server environments such as Kubernetes or cronjobs.

### Docker

We publish a [public Docker image `moov/bankcron`](https://hub.docker.com/r/moov/bankcron/) from Docker Hub and [OpenShift](https://quay.io/repository/moov/bankcron?tab=tags) published as `quay.io/moov/bankcron`.

Pull & start the Docker image:
```
docker run moov/bankcron:latest -- curl -v -L https://moov.io

<!doctype html>
...
```

### Command Line

You can [download the latest release](https://github.com/moov-io/bankcron/releases) for your platform.

```
$ bankcron curl -v -L https://moov.io

<!doctype html>
...
```

## Configuration settings

| Environmental Variable | Description | Default |
|-----|-----|-----|
| `LOG_FORMAT` | Format for logging lines to be written as. | Options: `json`, `plain` - Default: `plain` |
| `TZ` | IANA timezone location for determining banking day. Example: `America/New_York` |

## Getting help

 channel | info
 ------- | -------
Twitter [@moov](https://twitter.com/moov)	| You can follow Moov.io's Twitter feed to get updates on our project(s). You can also tweet us questions or just share blogs or stories.
[GitHub Issue](https://github.com/moov-io/bankcron/issues/new) | If you are able to reproduce a problem please open a GitHub Issue under the specific project that caused the error.
[moov-io slack](https://slack.moov.io/) | Join our slack channel (`#infra`) to have an interactive discussion about the development of the project.

## Supported and tested platforms

- 64-bit Linux (Ubuntu, Debian), macOS, and Windows
- Raspberry Pi

Note: 32-bit platforms have known issues and are not supported.

## Contributing

Yes please! Please review our [Contributing guide](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md) to get started! Check out our [issues for first time contributors](https://github.com/moov-io/bankcron/contribute) for something to help out with.

This project uses [Go Modules](https://github.com/golang/go/wiki/Modules) and uses Go v1.14 or higher. See [Golang's install instructions](https://golang.org/doc/install) for help setting up Go. You can download the source code and we offer [tagged and released versions](https://github.com/moov-io/bankcron/releases/latest) as well. We highly recommend you use a tagged release for production.

## License

Apache License 2.0 - See [LICENSE](LICENSE) for details.
