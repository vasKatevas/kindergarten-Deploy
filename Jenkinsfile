pipeline {
	agent any
		stages {
			stage('get Deploy') {
				steps {
					// Get some code from a GitHub repository
					git 'https://github.com/vasKatevas/kindergarten-Deploy'

				}
			}
			stage('install server requiremnts'){
				steps{
					sh '''
						ansible-galaxy install geerlingguy.mysql
						ansible-galaxy install geerlingguy.pip
						'''
				}
			}

			stage('install-requirements'){
				steps{
					sh '''
						cd ansible/ && ansible-playbook -i hosts.yml -l app01 install-requirements-non-docker.yml
						'''
				}
			}
			stage('clone-repos'){
				steps{
					sh '''
						cd ansible/ && ansible-playbook -i hosts.yml -l app01 clone-repos.yml
						'''
				}
			}
			stage('build run'){
				steps{
					sh '''
						cd ansible/ && ansible-playbook -i hosts.yml -l app01 build-run-non-docker.yml
						'''
				}
			}
			stage('run testing'){
				steps{
					sh '''
						cd ansible/ && ansible-playbook -i hosts.yml -l app01 testing.yml
						'''
				}
			}
		}
}
