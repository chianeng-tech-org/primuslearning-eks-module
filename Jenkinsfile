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
                    setParams() // function  
                }
            }   
        }

        stage("Build Infrastructure"){
            when { equals expected: 'build', actual: params.action }
            steps{
                script{
                    withAWS([credentials:"${params.creds}",region: "${params.region}"]){
                        sh"aws s3 ls"
                    }
                }
            }
        }
        stage("Destroy Infrastructure"){
            when { equals expected: 'destroy', actual: params.action }
            steps{
                script{
                    withAWS([credentials:"${params.creds}",region: "${params.region}"]){
                        sh"ls-l"
                    }
                }
            }
        }
    }
}

void setParams(){
    sh"sed -i 's/ENV/${params.environment}/g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's/TEAM/${params.team}/g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's/ACCOUNT/${params.account}/g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's/REGION/${params.region}/g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's#CIDR#${params.cidr}#g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's#PUBLIC#${params.public_cidr}#g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's#PRIVATE#${params.private_cidr}#g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's/DESIRED/${params.desired}/g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's/MAX/${params.max}/g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's/MIN/${params.min}/g' $WORKSPACE/vars/terraform.tfvars"
    sh"sed -i 's/REGION/${params.region}/g' $WORKSPACE/versions.tf"
    sh"sed -i 's/REGION/${params.region}/g' $WORKSPACE/provider.tf"
    sh"cat $WORKSPACE/vars/terraform.tfvars"
}

