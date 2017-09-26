CLI_DIR ?= cli
CLI_IMAGE ?= "arachnysdocker/athenapdf"
CLI_DOCKER_ARTIFACT_DIR ?= "/athenapdf/build/"

P="\\033[34m[+]\\033[0m"

buildcli:
	@echo "  $(P) buildcli"
	@rm -rf $(CLI_DIR)/build/
	@docker build --rm -t $(CLI_IMAGE)-build -f $(CLI_DIR)/Dockerfile.build $(CLI_DIR)/
	@docker run -t $(CLI_IMAGE)-build /bin/true
	@docker cp `docker ps -q -n=1`:$(CLI_DOCKER_ARTIFACT_DIR) $(CLI_DIR)/build/
	@docker rm -f `docker ps -q -n=1`

testcli:
	@echo "  $(P) testcli"
	@docker run --rm arachnysdocker/athenapdf athenapdf -S https://status.github.com/ | grep -a "PDF-1.4"
	@echo "<h1>stdin test</h1>" | docker run --rm -i arachnysdocker/athenapdf athenapdf -S - | grep -a "PDF-1.4"
