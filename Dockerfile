FROM debian:buster

RUN set -eux \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
		python-apt \
		python-dev \
		python-jmespath \
		python-pip \
		python-setuptools \
		sudo \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get purge -y --autoremove

RUN set -eux \
	&& pip install wheel \
	&& pip install ansible

# Add user with password-less sudo
RUN set -eux \
	&& useradd -m -s /bin/bash nomad \
	&& echo "nomad ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/nomad

# Copy files
COPY ./ /home/nomad/ansible
RUN set -eux \
	&& chown -R nomad:nomad /home/nomad/ansible

# Switch to user
USER nomad

# Change working directory
WORKDIR /home/nomad/ansible

# Systemd cannot be checked inside Docker, so replace it with a dummy role
RUN set -eux \
	&& mkdir roles/dummy \
	&& sed -i'' 's/systemd-meta/dummy/g' debian.yml

RUN set -eux \
	&& ( \
		echo "#!/bin/sh -eux"; \
		echo; \
		echo "# Ansible verbosity"; \
		echo "if ! set | grep '^verbose=' >/dev/null 2>&1; then"; \
		echo "    verbose=\"\""; \
		echo "else"; \
		echo "	if [ \"\${verbose}\" = \"1\" ]; then"; \
		echo "		verbose=\"-v\""; \
		echo "	elif [ \"\${verbose}\" = \"2\" ]; then"; \
		echo "		verbose=\"-vv\""; \
		echo "	elif [ \"\${verbose}\" = \"3\" ]; then"; \
		echo "		verbose=\"-vvv\""; \
		echo "	else"; \
		echo "		verbose=\"\""; \
		echo "	fi"; \
		echo "fi"; \
		echo; \
		echo "# Ansible tagged role (only run a specific tag)"; \
		echo "if ! set | grep '^tag=' >/dev/null 2>&1; then"; \
		echo "	tag=\"\""; \
		echo "fi"; \
		echo; \
		echo; \
		# ---------- Only run a specific tag ----------
		echo "if [ \"\${tag}\" != \"\" ]; then"; \
			echo "	role=\"\$( echo \"\${tag}\" | sed 's/-/_/g' )\""; \
			echo "	# [install] (only tag)"; \
			echo "	ansible-playbook debian.yml \${verbose} --diff -t bootstrap-system-apt-repo"; \
			echo "	ansible-playbook debian.yml \${verbose} --diff -t \${tag}"; \
		echo; \
		echo "else"; \
		echo; \
			# ---------- Installation ----------
			echo; \
			echo "		# [INSTALL] Normal playbook"; \
			echo "		if ! ansible-playbook debian.yml \${verbose} --diff; then"; \
			echo "			 ansible-playbook debian.yml \${verbose} --diff"; \
			echo "		fi"; \
			echo "	fi"; \
			echo; \
			echo "	apt list --installed > install1.txt"; \
			echo; \
			\
			# ---------- Installation (2nd round) ----------
			echo "	# Full install 2nd round"; \
			echo "	if ! ansible-playbook debian.yml \${verbose} --diff; then"; \
			echo "		 ansible-playbook debian.yml \${verbose} --diff"; \
			echo "	fi"; \
			echo; \
			echo "	apt list --installed > install2.txt"; \
			echo; \
			# ---------- Validate diff ----------
			echo "	# Validate"; \
			echo "	diff install1.txt install2.txt"; \
			echo; \
		echo "fi"; \
		\
	) > run-tests.sh \
	&& chmod +x run-tests.sh

ENTRYPOINT ["./run-tests.sh"]