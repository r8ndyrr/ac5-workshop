CURRENT_DIR := $(shell pwd)

.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: l3ls
l3ls: ## Deploy l3ls lab
	cp ceos_lab.tar.gz l3ls-lab
	docker run --rm -it --privileged --name l3ls -w /lab -v $(CURRENT_DIR)/l3ls-lab:/lab -v /var/lib/docker -e PASSWORD=labpass124 -p 5000:5000 ghcr.io/ankudinov/ac5-workshop/lab:uid-1009-rev0.2

.PHONY: l2ls
l2ls: ## Deploy l2ls lab
	cp ceos_lab.tar.gz l2ls-lab
	fixdocker run --rm -it --privileged --name l2ls -w /lab -v $(CURRENT_DIR)/l2ls-lab:/lab -v /var/lib/docker -e PASSWORD=labpass125 -p 5000:5000 ghcr.io/ankudinov/ac5-workshop/lab:uid-1009-rev0.2
