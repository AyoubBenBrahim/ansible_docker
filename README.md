
python3 -m pip install --user ansible
export PATH="/Users/ayb*****/Library/Python/3.9/bin:$PATH"


ssh-keyscan -H 192.168.42.20 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.42.110 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.42.120 >> ~/.ssh/known_hosts

ansible-playbook -i provisioning/inventory.yaml provisioning/playbook.yaml

wordpress ==> https://192.168.42.20
phpMyAdmin ==> https://192.168.42.20:8080
