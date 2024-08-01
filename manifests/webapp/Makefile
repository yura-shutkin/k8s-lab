.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

################################################################################
### WebApp ######################################################################
################################################################################
RELEASE_NAME=webapp
NS=webapp
VALUES_FILE=values.yaml
####

# __hidethis__ helm upgrade [RELEASE] [CHART] [flags]
.PHONY: install
install: ## 			Deploy chart
	@helm upgrade --install ${RELEASE_NAME} . -n ${NS} -f ${VALUES_FILE} --create-namespace

.PHONY: uninstall
uninstall: ## 			Delete chart
	@helm uninstall -n ${NS} ${RELEASE_NAME}

.PHONY: render
render: ## 			Render chart
	@helm template ${RELEASE_NAME} . -n ${NS} -f ${VALUES_FILE}
