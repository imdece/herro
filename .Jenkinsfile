/*
* DO NOT UPDATE THIS FILE: Updating this file may break the breakglass process.
*/

@Library('i2g-jenkins-shared-library@dhruva/update_step_sequence_to_enable_dockerized_ci-pretest') _

/* Declaring variables  */
    def APPLICATION="herro"

/* Deploy logic */
try{

    /* Docker pipeline for performing the build */
    runSingleBranchCI(
        application: APPLICATION,
        )

    if( "$env.BRANCH_NAME" =~ "${env.BRANCH_REGEX}" ){
        helmfileDeploy(
            imageName: APPLICATION,
            environment: "int"
            )

        timeout(time: 30, unit: 'DAYS') {
            input 'Proceed to qa?'
        }

        helmfileDeploy(
            imageName: APPLICATION,
            environment: "qa"
            )

        timeout(time: 30, unit: 'DAYS') {
            input 'Proceed to staging?'
        }

        helmfileDeploy(
            imageName: APPLICATION,
            environment: "staging"
            )

        timeout(time: 30, unit: 'DAYS') {
            input 'Proceed to prod?'
        }

        helmfileDeploy(
            imageName: APPLICATION,
            environment: "prod"
            )
    }

}catch(exc){
    notifyBuild()
    error exc.message
    currentBuild.result = 'FAILURE'
}finally{
    if ("$env.BUILD_SUCCESSFUL" == 'True') {
        notifyBuild('SUCCESSFUL')
        }
}

/* internal functions */
def notifyBuild(String buildStatus = 'FAILED') {
    // build status of null means successful
    buildStatus =  buildStatus ?: 'FAILED'

    // Default values
    def colorCode = '#C5343B'
    def subject = "*$buildStatus*: $env.BRANCH_NAME"
    def summary = "$subject \n\n See build at: $env.BUILD_URL"
    def branch = "$env.BRANCH_NAME"

    // Override default values based on build status
    if (buildStatus == 'SUCCESSFUL') {
    colorCode = '#8FC567' // GREEN
    } else {
    colorCode = '#C5343B' // RED
    }

    // Send notifications excluding PRs
    if (branch[0,1] != 'PR') {
    //slackSend (channel: 'alerts_herro', color: colorCode, message: summary)
    echo "$summary"
    }
}
