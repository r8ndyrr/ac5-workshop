#!/usr/bin/env bash

# init.sh

set +e
pip install -r requirements.txt
wget https://raw.githubusercontent.com/textualize/rich/refs/heads/master/examples/tree.py
echo "alias rich='python3 tree.py $(pwd)'" >> /home/avd/.zshrc
cp -r /home/avd/.ansible/collections/ansible_collections/arista/avd/examples/single-dc-l3ls/* .
