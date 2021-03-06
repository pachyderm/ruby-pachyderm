SHELL := /bin/bash

docker-build-proto:
	pushd proto && \
		docker build -t pachyderm_ruby_proto .

proto: docker-build-proto
	find ./proto/pachyderm/src/client -maxdepth 7 -regex ".*\.proto" \
	| xargs tar cf - \
	| docker run -i pachyderm_ruby_proto \
	| tar xf -

test-basic:
	bundle exec ruby -I ./lib test/test.rb

test-auth:
	pachctl enterprise activate  $$(aws s3 cp s3://pachyderm-engineering/test_enterprise_activation_code.txt -)
	bundle exec ruby -I ./lib test/auth.rb

test: test-basic test-auth

init:
	git submodule update --init

ci-setup:
	@# TODO: Install any ruby / proto libs here
	sudo pip install awscli
	echo -e "$${AWS_ACCESS_KEY_ID}\n$${AWS_SECRET_ACCESS_KEY}\n\n\n" | aws configure
	pushd proto/pachyderm && \
		sudo ./etc/testing/ci/before_install.sh && \
		curl -o /tmp/pachctl.deb -L https://github.com/pachyderm/pachyderm/releases/download/v$$(cat ../../VERSION)/pachctl_$$(cat ../../VERSION)_amd64.deb  && \
		sudo dpkg -i /tmp/pachctl.deb && \
		make launch-kube && \
		popd
	docker version
	which pachctl
	pachctl deploy local
	until timeout 1s ./proto/pachyderm/etc/kube/check_ready.sh app=pachd; do sleep 1; done
	pachctl version

sync:
	# NOTE: This task must be run like:
	# PACHYDERM_VERSION=1.2.3 make sync
	if [[ -z "$$PACHYDERM_VERSION" ]]; then \
		exit 1; \
	fi
	echo $$PACHYDERM_VERSION > VERSION
	# Will update the protos to match the VERSION file
	pushd proto/pachyderm && \
		git fetch --all && \
		git checkout $$(cat ../../VERSION) && \
		popd
	# Rebuild w latest proto files
	make proto
build-gem:
	expr $$(cat BUILD) + 1 > BUILD
	gem build pachyderm.gemspec

release-gem: build-gem
	@# Setup your gem credentials a la:
	@# curl -u sean https://rubygems.org/api/v1/api_key.yaml > ~/.gem/credentials; chmod 0600 ~/.gem/credentials
	gem push pachyderm-$$(cat VERSION).$$(cat BUILD).gem

.PHONY: test
