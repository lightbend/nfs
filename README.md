# NFS Provisioner

This Helm chart is based on the [external-storage](https://github.com/kubernetes-incubator/external-storage/tree/master/nfs) project. It installs an NFS storage provsioner which can be used to dynamically provision NFS persistent volumes.

## Usage

#### Installing on OpenShift

To Install the chart on OpenShift, run:

```bash
$ helm repo add lightbend https://repo.lightbend.com/helm-charts
$ helm install lightbend/fdp-nfs --namespace <provisioner-namespace>
```

and then run:

```bash
$ oc adm policy add-scc-to-user nfs-provisioner -n<provisioner-namespace> -z <chart-created-serviceaccount>
```

to add the  `nfs-provisioner` security context constraint (*SCC*) created during `helm install` to the service account used by the provisioner deployment. This enables `hostPath` Volume plugin, allowing the provisioner pod to start.

#### Installing on Non-OpenShift Kubernetes

No SCC is involved in this case:

```bash
$ helm repo add lightbend https://repo.lightbend.com/helm-charts
$ helm install lightbend/fdp-nfs --namespace <provisioner-namespace> --set onOpenShift=false
```

### Creating an NFS backed Persistent Volume Claim

The chart creates a StorageClass called `nfs-sc` and creates a sample PVC that uses it.

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: testpvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Mi
  storageClassName: nfs-sc
```

An NFS PV will be automatically provisioned and bound to the `testpvc`. To provision another PV, following the same example by using the `nfs-sc` as the StorageClass for your PVC.


