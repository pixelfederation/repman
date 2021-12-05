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
