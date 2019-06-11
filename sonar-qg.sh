sonar_host_name=$1
project_key=$2

# sudo apt-get install jq

apt-get update -y
sudo apt-get install -y jq

ce_status=$(curl -s ${sonar_host_name}/api/qualitygates/project_status?projectKey=${project_key} | jq --raw-output '.projectStatus.status')

echo ${sonar_host_name}
echo "QG Script --> Status of SonarQube task is ${ce_status}"

if [ ${ce_status} != "OK" ]; then
  echo "QG Script --> Quality gate is not OK - exiting with error"
  exit 1
else
  echo "QG Script --> Quality gate is OK - exiting with Success"
  exit 0
fi