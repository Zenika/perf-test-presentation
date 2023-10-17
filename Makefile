
##  ------------
##@ Presentation
##  ------------

presentation: ## Start the presentation web server
	@docker run --rm -p 1948:1948 -p 35729:35729 -v $(shell pwd)/Presentation:/slides webpronl/reveal-md:latest /slides --watch --css style/custom.css --highlight-theme a11y-dark
.PHONY: presentation

presentation-w-notes: .clean-presentation .prepare-print## Start the presentation web server (with notes)
	@docker run -d -p 1948:1948 -p 35729:35729 -v $(shell pwd)/Presentation:/slides --name reveal-md webpronl/reveal-md:latest /slides --css style/custom.css --highlight-theme a11y-dark
	@sh ./tools/print-mode.sh
	@$(MAKE) .clean-presentation
.PHONY: presentation-w-notes

export-pdf: .clean-presentation .prepare-print ## Export presentation to pdf (used in GH action)
	@docker run -d -p 1948:1948 -v $(shell pwd)/Presentation:/slides --name reveal-md webpronl/reveal-md:latest /slides --css style/custom.css --highlight-theme a11y-dark
	@mkdir generation_tmp && chmod 777 generation_tmp
	@sleep 5
	@sh ./tools/print-pdf.sh
	@$(MAKE) .clean-presentation
.PHONY: export-pdf

.prepare-print:
	@cp Presentation/style/print-options.json Presentation/reveal.json
.PHONY: .prepare-print

.clean-presentation:
	@docker stop reveal-md || true
	@docker rm reveal-md || true
	@rm -rf generation_tmp || true
	@rm -rf Presentation/reveal.json || true
.PHONY: .clean-presentation

##  -------------
##@ Demonstration
##  -------------

## Task

##  ----
##@ Misc
##  ----

.DEFAULT_GOAL := help
APPLICATION_TITLE := Performance tests Presented by Zenika \n =====================================
.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.* ##"; printf "\n\033[32;1m ${APPLICATION_TITLE}\033[0m\n\n\033[1mUsage:\033[0m\n  \033[31mmake \033[36m<option>\033[0m\n"} /^[%a-zA-Z_-]+:.* ## / { printf "  \033[33m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' ${MAKEFILE_LIST}

##@
