include /usr/share/selinux/devel/Makefile

build: pulpcore_port.pp pulpcore.pp pulpcore_rhsmcertd.pp ## Build SELinux policies

help: ## Show this help.
	@sed -ne '/@sed/!s/:.\+## /: /p' $(firstword $(MAKEFILE_LIST))

docs: ## Build unified docs.
	pulp-docs build

servedocs: ## Serves unified docs.
	pulp-docs serve

.PHONY: build docs servedocs help
