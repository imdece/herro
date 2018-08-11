pipeline {
  agent { label 'int' }

  stages {
    stage('test') {
      steps {
        sh 'echo ok'
      }
    }

    stage('build') {
      when { branch 'master' }
      steps {
        sh 'echo ok'
      }
    }
  }

  post {
    always {
      cleanWs()
    }
  }
}
