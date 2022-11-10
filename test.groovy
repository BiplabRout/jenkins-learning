node {
    stage('testing') {
        dir('demo'){
                sh (script: "echo hello")
    }
}
}
