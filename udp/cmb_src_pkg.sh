#!/bin/bash

mkdir udp
cd udp
for proj in ucore uagent udeploy uguard umc umon urman usql ustats uterm; do
		git clone git@10.186.18.21:universe/${proj}.git
		$(cd ${proj} && git checkout -b 2.18.10.0/rel origin/2.18.10.0/rel)
		revision=$(cd ${proj} && echo "$(git rev-parse --abbrev-ref HEAD)/$(git rev-parse HEAD)")
		echo "${proj}: ${revision}">>README
		rm -rf ${proj}/.git
done
cd ..
tar -zxf udp.tar.gz udp
