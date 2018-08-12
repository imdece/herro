@Library('i2g-jenkins-shared-library') _

pipeline {
  agent { label 'int' }

  options {
    timeout(time: 20, unit: 'MINUTES')
  }

  tools {
    nodejs '8.9.0'
  }

  environment {
    SHA = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()
    GIT_COMMIT_DETAIL = sh(script: "git log --pretty=format:'Commit: %h _%s_, By *%an*' --abbrev-commit -1", returnStdout: true)
    SLACK_CHANNEL = 'tmp'
  }

  stages {
    stage('build') {
      steps {
        script {
          dockerBuild(
            imageName: 'herro',
            imageTags: [SHA],
            gitSha: SHA,
            dockerFile: 'Dockerfile',
            pushImage: true
          )
        }
      }
    }
  }

  post {
    always {
      sh "docker-compose down --remove-orphans --volumes"
      cleanWs()
      notifyBuild(
        buildStatus: currentBuild.currentResult,
        branchName: BRANCH_NAME,
        gitCommitDetail: GIT_COMMIT_DETAIL,
        buildURL: BUILD_URL,
        slackChannel: SLACK_CHANNEL,
        notifyOnPR: false
      )
    }
  }
}
