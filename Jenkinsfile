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
                    withCredentials([file(credentialsId: 'slave_kubeconfig', variable: 'KUBECONFIG_ITI'),
                                    file(credentialsId: 'service_account_key', variable: 'KEYY')]) 
                    {
                        sh """
                            gcloud auth activate-service-account --key-file ${KEYY}
                            helm upgrade --install bakehouseapp ./bakehousechart/ --kubeconfig ${KUBECONFIG_ITI} --set image.tag=v${BUILD_NUMBER} --values bakehousechart/master-values.yaml
                        """
                    }
                }
            }
        }
    }
}
