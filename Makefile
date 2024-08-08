.PHONY : build clone-sniffs clone-sniff-wordpress clone-sniff-utils clone-sniff-extra

PHPCS_WORDPRESS_VERSION = 3.1.0
PHPCS_UTILS_VERSION = 1.0.11
PHPCS_EXTRA_VERSION = 1.2.1
SNIFFS_DIR = .sniffs

build: clone-sniffs
	docker build -t amackiewicz/phpcs . --progress plain

clone-sniffs: clone-sniff-wordpress clone-sniff-utils clone-sniff-extra

clone-sniff-wordpress:
	if [ ! -d "$(SNIFFS_DIR)/wordpress" ]; then git clone git@github.com:WordPress/WordPress-Coding-Standards.git $(SNIFFS_DIR)/wordpress/; fi
	git -C $(SNIFFS_DIR)/wordpress checkout main
	git -C $(SNIFFS_DIR)/wordpress pull
	git -C $(SNIFFS_DIR)/wordpress checkout tags/$(PHPCS_WORDPRESS_VERSION)

clone-sniff-utils:
	if [ ! -d "$(SNIFFS_DIR)/utils" ]; then git clone git@github.com:PHPCSStandards/PHPCSUtils.git $(SNIFFS_DIR)/utils/; fi
	git -C $(SNIFFS_DIR)/utils checkout stable
	git -C $(SNIFFS_DIR)/utils pull
	git -C $(SNIFFS_DIR)/utils checkout tags/$(PHPCS_UTILS_VERSION)

clone-sniff-extra:
	if [ ! -d "$(SNIFFS_DIR)/extra" ]; then git clone git@github.com:PHPCSStandards/PHPCSExtra.git $(SNIFFS_DIR)/extra/; fi
	git -C $(SNIFFS_DIR)/extra checkout stable
	git -C $(SNIFFS_DIR)/extra pull
	git -C $(SNIFFS_DIR)/extra checkout tags/$(PHPCS_EXTRA_VERSION)
