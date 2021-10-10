versions = ['10.1', '10.2', '10.3', '10.4', '10.5']

pipeline {

    agent { label 'docker-agent' }

    stages {
        stage ( "Building") {
            steps {
                script {
                    versions.each { version ->
                        docker.withRegistry('', 'docker-hub-credentials') {
                            stage("version ${version}") {
                                sh "make build v=${version}"
                                sh "make push v=${version}"
                            }
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'make remove'
            }
        }
        cleanup {
            cleanWs()
        }
    }
}
