## [1.0.14]
### Fixed
- Set HTTPS and SERVER_PORT fastcgi params after include fastcgi_params so SERVER_PORT is not overridden to 80

## [1.0.13]
### Changed
- Add MAILER_DSN to env variables fetched from secret

## [1.0.12]
### Changed
- Add HTTPS and SERVER_PORT parameters to configmap

## [1.0.11]
### Changed
- Added cronjob ttlSecondsAfterFinished

## [1.0.10]
### Changed
- Change cronjob command template

## [1.0.9]
### Changed
- Logs to stdout, nginx server config set to catch-all

## [1.0.8]
### Changed
- Add fluentbit enabled option true/false

## [1.0.7]
### Changed
- Deprecated "autoscaling/v2beta2" to "autoscaling/v2"

## [1.0.6]
### Changed
- Update repman, nginx to latest versions

## [1.0.5]
### Changed
- Database credentials from secret

## [1.0.4]
### Changed
- Add fluentbit

## [1.0.3]
### Changed
- Add shared session,
- Add hpa

## [1.0.0]
### Changed
- Initial version of repman chart
