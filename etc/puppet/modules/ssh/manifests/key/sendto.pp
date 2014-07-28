class ssh::key::sendto() {
	$key_file = "~/.ssh/id_rsa.pub"
	exec {
		"auto_generate_ssh_key":
			command => "ssh-keygen -f $key_file -q -N ''",
                        unless => "ls $key_file";
	}

	file {
		"/root/.ssh/send_key_to.sh":
			content => "#!/bin/bash
scp $key_file \$1:/tmp/$hostname
ssh \$1 'cat /tmp/$hostname >> ~/.ssh/authorized_keys; rm /tmp/$hostname'",
	}
}
