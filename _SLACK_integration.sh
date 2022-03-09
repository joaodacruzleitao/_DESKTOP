#!/usr/bin/env bash

#G9
curl -X POST -H 'Content-type: application/json' --data '{"text":"Ola Mundo!!"}' https://hooks.slack.com/services/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

#CX3103
curl -X POST -H 'Content-type: application/json' --data '{"text":"Ola Mundo!!"}' https://hooks.slack.com/services/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

#G14
curl -X POST -H 'Content-type: application/json' --data '{"text":"Ola Mundo!!"}' https://hooks.slack.com/services/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

curl -X POST -H 'Content-type: application/json' --data '{"text":"Ola Mundo!!"}' https://hooks.slack.com/services/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
curl -X POST -H 'Content-type: application/json' --data '{"text":"Ola Mundo!!"}' https://hooks.slack.com/services/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
curl -X POST -H 'Content-type: application/json' --data '{"text":"Ola Mundo!!"}' https://hooks.slack.com/services/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

curl -X POST -H 'Content-type: application/json' --data '{"text":"a"}' https://hooks.slack.com/services/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

cd /usr/local/src || exit
wget http://repo.imunify360.cloudlinux.com/defence360/i360deploy.sh
bash i360deploy.sh --key IMUNAvR08Iyvwfzpyk3

/usr/local/cpanel/bin/update-roundcube-db --force
