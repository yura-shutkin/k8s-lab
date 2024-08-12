################################################################################
### Kubectl ####################################################################
################################################################################

.PHONY: apply-manifests
apply-manifests: ##		Apply manifests from manifests directory
	@kubectl -n $(NS) apply -f manifests

.PHONY: delete-manifests
delete-manifests: ##		Delete manifests from manifests directory
	@kubectl -n $(NS) delete -f manifests
