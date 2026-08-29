
[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_host_key_checking=false
ansible_ssh_private_key_file=${ssh_key_path}



[control]
%{ for name, inst in control ~}
${name} ansible_connection=local ansible_user=${inst.user}
%{ endfor ~}

[ubuntu_workers]
%{ for name, inst in ubuntu_workers ~}
${name} ansible_host=${inst.private_ip} ansible_user=${inst.user}
%{ endfor ~}

[redhat]
%{ for name, inst in redhat ~}
${name} ansible_host=${inst.public_ip} ansible_user=${inst.user}
%{ endfor ~}

[amazon]
%{ for name, inst in amazon ~}
${name} ansible_host=${inst.public_ip} ansible_user=${inst.user}
%{ endfor ~}