pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: ['build', 'destroy'], description: 'Build Or Destroy Infrastructure')
        string(name: 'environment', defaultValue: 'default', description: 'Environment name')
        string(name: 'team', defaultValue: 'default', description: 'Team name')
        string(name: 'account', defaultValue: 'default', description: 'account name')
        string(name: 'region', defaultValue: 'us-east-1', description: 'region')
        string(name: 'creds', defaultValue: '', description: 'credentials id')
        string(name: 'cidr', defaultValue: '', description: 'vpc cidr')
        string(name: 'public_cidr', defaultValue: '', description: 'public cidrs')
        string(name: 'private_cidr', defaultValue: '', description: 'private cidrs')
        string(name: 'desired', defaultValue: '', description: 'node group desired capacity')
        string(name: 'max', defaultValue: '', description: 'node group max capacity')
        string(name: 'min', defaultValue: '', description: 'node group min capacity') 
    }
    stages{
        stage("init build params"){
            steps{
                script{
                    sh"cat $WORKSPACE/var/terraform.tfvars"  
                }
            }   
        }

        stage("Build Infrastructure"){
            when { equals expected: 'build', actual: params.action }
            steps{
                script{
                    sh"ls -l"
                }
            }
        }
        stage("Destroy Infrastructure"){
            when { equals expected: 'destroy', actual: params.action }
            steps{
                script{
                    sh"ls -l"
                }
            }
        }
    }
}