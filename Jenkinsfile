pipeline {
    agent {
        docker { image 'node:22.14.0-alpine3.21' }
    }
    stages {
        stage('Test') {
            steps {
                echo 'run docker image node'
                sh 'node --eval "console.log(process.platform,process.env.CI)"'
            }
        }
        stage('stage2') {
            steps {
                echo 'hello stage 2'
            }
        }
        stage('stage3') {
            steps {
                echo 'running job1 from Jenkins'
                build job: 'job1'
            }
        }
    }
}