pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: ['build', 'destroy'], description: 'Build Or Destroy Infrastructure')
    }
    stages{
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