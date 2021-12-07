# Repman

[Repman](https://repman.io/) is Private PHP Package Repository Manager


## Prerequisites

-	Kubernetes 1.21 or later

## Installing the Chart

The chart can be installed as follows:

```console
$ helm repo add repman https://pixelfederation.github.io/repman
$ helm --namespace=repman install repman pixelfederation/repman
```

Exec to pod and run:
```
kubectl exec -ti POD_NAME bash -c api
bin/console d:m:m --no-interaction && bin/console messenger:setup-transports --no-interaction && bin/console repman:security:update-db && bin/console assets:install && php-fpm
```

## Uninstalling the Chart

To uninstall/delete the `repman` deployment:

```console
$ helm uninstall repman
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

See `values.yaml` for configuration notes. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install repman \
  pixelfederation/repman \
  --set rbac.create=false
```

The above command disables automatic creation of RBAC rules.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install repman pixelfederation/repman -f values.yaml
```

Store Sessions in a PostgreSQL:

```
CREATE TABLE sessions (
    sess_id VARCHAR(128) NOT NULL PRIMARY KEY,
    sess_data BYTEA NOT NULL,
    sess_lifetime INTEGER NOT NULL,
    sess_time INTEGER NOT NULL
);
CREATE INDEX sessions_sess_lifetime_idx ON sessions (sess_lifetime);
```
