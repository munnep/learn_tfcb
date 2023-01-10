got an error with the vault part

Terraform v0.14.11
helm_release.vault[0]: Creating...

Error: unable to build kubernetes objects from release manifest: [unable to recognize "": no matches for kind "ClusterRoleBinding" in version "rbac.authorization.k8s.io/v1beta1", unable to recognize "": no matches for kind "RoleBinding" in version "rbac.authorization.k8s.io/v1beta1", unable to recognize "": no matches for kind "MutatingWebhookConfiguration" in version "admissionregistration.k8s.io/v1beta1"]

  on vault.tf line 1, in resource "helm_release" "vault":
   1: resource "helm_release" "vault" {


Operation failed: failed running terraform apply (exit 1)

Terraform v0.14.11
helm_release.vault[0]: Creating...

Error: unable to build kubernetes objects from release manifest: [unable to recognize "": no matches for kind "ClusterRoleBinding" in version "rbac.authorization.k8s.io/v1beta1", unable to recognize "": no matches for kind "RoleBinding" in version "rbac.authorization.k8s.io/v1beta1", unable to recognize "": no matches for kind "MutatingWebhookConfiguration" in version "admissionregistration.k8s.io/v1beta1"]

  on vault.tf line 1, in resource "helm_release" "vault":
   1: resource "helm_release" "vault" {



The warning is self-explanatory. In API rbac.authorization.k8s.io/v1beta1 the ClusterRoleBinding object is deprecated and you won't able to use it in k8s version v1.22+.

The API v1 is the stable version and you should always use the stable one if possible.









Terraform v0.14.11
helm_release.consul[0]: Destroying... [id=hashicorp-learn-consul]

Error: uninstallation completed with 4 error(s): clusterrolebindings.rbac.authorization.k8s.io "consul-client" is forbidden: User "hc-5372532dbacb4863afdfdc0d508@appspot.gserviceaccount.com" cannot delete resource "clusterrolebindings" in API group "rbac.authorization.k8s.io" at the cluster scope: requires one of ["container.clusterRoleBindings.delete"] permission(s).; clusterrolebindings.rbac.authorization.k8s.io "consul-server" is forbidden: User "hc-5372532dbacb4863afdfdc0d508@appspot.gserviceaccount.com" cannot delete resource "clusterrolebindings" in API group "rbac.authorization.k8s.io" at the cluster scope: requires one of ["container.clusterRoleBindings.delete"] permission(s).; clusterroles.rbac.authorization.k8s.io "consul-client" is forbidden: User "hc-5372532dbacb4863afdfdc0d508@appspot.gserviceaccount.com" cannot delete resource "clusterroles" in API group "rbac.authorization.k8s.io" at the cluster scope: requires one of ["container.clusterRoles.delete"] permission(s).; clusterroles.rbac.authorization.k8s.io "consul-server" is forbidden: User "hc-5372532dbacb4863afdfdc0d508@appspot.gserviceaccount.com" cannot delete resource "clusterroles" in API group "rbac.authorization.k8s.io" at the cluster scope: requires one of ["container.clusterRoles.delete"] permission(s).

