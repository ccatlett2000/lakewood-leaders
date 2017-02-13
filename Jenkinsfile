node('basic') {
  def commit_id
  def app
  def tag

  stage('Checkout source') {
    checkout scm
  }

  stage('Build image') {
    app = docker.build 'realmicprojects/lakewoodleaders'
  }

  stage('Push image') {
    withCredentials([string(credentialsId: 'docker-hub-password', variable: 'DOCKER_HUB_PASSWORD')]) {
      sh 'docker login --username ccatlett2000 --password $DOCKER_HUB_PASSWORD'
    }
    sh 'git describe --tags > .git-tag'
    tag = readFile('.git-tag').trim()
    app.push "${tag}"
  }

  stage('Deploy to cluster') {
    milestone
    sh "kubectl --namespace default set image deployment lakewoodleaders lakewoodleaders=realmicprojects/lakewoodleaders:${tag}"
  }
}
