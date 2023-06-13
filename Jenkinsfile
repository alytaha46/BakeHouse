pipeline {
    agent { label 'jenkins_slave' }
    stages {
        stage('build') {
            steps {
                echo 'build'
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker_login', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                            sh '''
                                docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                                docker build -t alytaha46/bakehouseproject:v${BUILD_NUMBER} .
                                docker push alytaha46/bakehouseproject:v${BUILD_NUMBER}
                            '''
                    }
                }
            }
        }
        stage('deploy') {
            steps {
                echo 'deploy'
                script {
                    // Check if the release is already deployed
                    def releaseStatus = sh(returnStatus: true, script: "helm status bakehouseapp")
                    // Install or upgrade the custom chart using Helm based on the release status
                    if (releaseStatus == 0) {
                        sh """
                            helm upgrade bakehouseapp ./bakehousechart/ --set image.tag=v${BUILD_NUMBER} --values bakehousechart/master-values.yaml --namespace bakehouse-ns
                        """
                    } else {
                        sh """
                            helm install bakehouseapp ./bakehousechart/ --set image.tag=v${BUILD_NUMBER} --values bakehousechart/master-values.yaml --namespace bakehouse-ns
                        """
                    }
            }
            }
        }
    }
}
