#!/bin/bash

#pwd && ls -l "$(pwd)/../zest/marathon-local-integration-port-9090.zst"
#cp "$(pwd)/../zest/marathon-local-integration-port-9090.zst" /home/runner/.ZAP/script.zst && ls -l /home/runner/.ZAP/script.zst
#cp "$(pwd)/../zest/marathon-local-integration-port-9090.zst" /home/runner/work/MarathonReloaded/MarathonReloaded/ZAP_2.11.0/script.zst && ls -l /home/runner/work/MarathonReloaded/MarathonReloaded/ZAP_2.11.0/script.zst

# setup and initialize ZAP
curl -s "http://localhost:7777/JSON/context/action/newContext/?zapapiformat=JSON&contextName=marathon"
curl -s "http://localhost:7777/JSON/context/action/includeInContext/?zapapiformat=JSON&contextName=marathon&regex=http://localhost:9090/.*"
curl -s "http://localhost:7777/JSON/core/action/setMode/?zapapiformat=JSON&mode=attack"

# run test automation
curl -s "http://localhost:7777/JSON/script/view/listEngines/?zapapiformat=JSON"
curl -s "http://localhost:7777/JSON/script/action/load/?zapapiformat=JSON&scriptName=Marathon.zst&scriptType=standalone&scriptEngine=Mozilla%20Zest&fileName=$(pwd)/../zest/Marathon.zst&scriptDescription=&charset="
#curl -s "http://localhost:7777/JSON/script/view/listScripts/?zapapiformat=JSON"
curl -s "http://localhost:7777/JSON/script/action/runStandAloneScript/?zapapiformat=JSON&scriptName=Marathon.zst" # keep aware that body assertions should be emptied in the Zest script to avoid errors about illegal characters etc...

echo "" && echo "Running ZAP guided scan..."
