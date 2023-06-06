pipeline {
    agent { label 'jenkins_slave' }
    //parameters {
    //        choice(name: 'ENV', choices: ['dev', 'test', 'prod',"release"])
    //}
    stages {
        stage('build') {
            steps {
                echo 'build'
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker_login', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                            sh '''
                                docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                                docker build -t alytaha46/bakehouseitismart:v${BUILD_NUMBER} .
                                docker push alytaha46/bakehouseitismart:v${BUILD_NUMBER}
                                echo ${BUILD_NUMBER} > ../build.txt
                            '''
                    }
                }
            }
        }
        stage('deploy') {
            steps {
                echo 'deploy'
                script {
                    withCredentials([file(credentialsId: 'slave_kubeconfig', variable: 'KUBECONFIG_ITI')]) {
                        sh '''
                            export BUILD_NUMBER=$(cat ../build.txt)
                            mv Deployment/deploy.yaml Deployment/deploy.yaml.tmp
                            cat Deployment/deploy.yaml.tmp | envsubst > Deployment/deploy.yaml
                            rm -f Deployment/deploy.yaml.tmp
                            kubectl apply -f Deployment --kubeconfig ${KUBECONFIG_ITI} -n devops-tools
                        '''
                    }
                }
            }
        }
    }
}
