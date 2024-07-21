#!/bin/bash
# simple clear check procedure.

# use -demo to skip some of the regions
CCDEMO=""
if [[ $* == *-demo* ]]
then
    echo "DEMO MODE ACTIVATED!"
    CCDEMO="-demo" #skip regions for demo
fi

# acctually skip things because this is an external conference and public repo
CCDEMO="-demo"

# this function typically sets environment variables for auth, but this is a demo
assume () {
    echo "assuming account {$1}"
    sleep 0.5
    echo "you now have root access... jk"
}

# print execute command, then wait for input before proceeding
pe () {
    echo ""
    echo $1
    eval $1
    read -n 1 -s -r -p "Press any key to continue"
    echo ""
    echo ""
}

# dont actually execute
pene () {
    echo ""
    echo $1
    echo "executing {$1}\n     .....waiting for output"
    sleep 0.5
    echo "THAT output"
    read -n 1 -s -r -p "Press any key to continue"
    echo ""
    echo ""
}

check_region () {
    currentContext="$1"
    echo "checking region $currentContext"
    # pe "kubectl config view"
    if [[ $* == *-demo*  ]]
    then
        echo "    demo skip - kubectl get pods --all-namespaces | grep -i -E 'failed|crash|pending'"
        echo "    demo skip - kubectl get nodes"
        echo "    demo skip - kubectl top nodes"
    else
        pene "kubectl get pods --all-namespaces | grep -i -E 'failed|crash|pending'"
        pene "kubectl get nodes"
        pene "kubectl top nodes"
        # pe "kubectl describe hpa --all-namespaces"
    fi
}

echo "Press ENTER to monitor kube"

echo "--- DEV CLUSTERS ---"

assume dev-account

# kubectx dev-cluster-1 
sleep 1
check_region 'DEV-cluster1'

# kubectx dev-cluster-2
sleep 1
check_region 'DEV-cluster2' $CCDEMO

# cluster 3

echo "--- Prod CLUSTERS ---"
assume prod-account
# kubectx prod-cluster-1 
sleep 1
check_region 'PROD-cluster1' $CCDEMO

# kubectx prod-cluster-2 
sleep 1
check_region 'PROD-cluster2' $CCDEMO

echo "--- Prod CLUSTERS other cloud ---"
# kubectx prod-cluster-1-cloud-2
sleep 1
check_region 'PROD-OtherCloud-cluster1' $CCDEMO

# kubectx prod-cluster-2-cloud-2
sleep 1
check_region 'PROD-OtherCloud-cluster2' $CCDEMO

# remove stored sessions
# cloud-provider-cli clear
assume non-cluster-cloud-auth
# required for browser
# cloud-provider-cli login account-I-use-for-ui
sleep 1
echo "If browser requests a logout, please logout before continuing."
read -n 1 -s -r -p "Press any key to continue"
# cloud-provider-cli login account-I-use-for-ui
sleep 0.5
boards=(
    $EVENT_WEBSITE
    "https://github.com/CorwinDiamond/shell_script_101"
    'https://thatconference.com/wi/2024/'
    'https://www.gnu.org/software/bash/'
    'https://grafana.com/'
    'event_slides/Slide-THAT-Sponsors.png'
)

for board in "${boards[@]}"; do 
    open $board
    echo $board
    sleep 0.5
done
