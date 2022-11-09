node {
    stage('Example') {
        dir('demo'){
		sh (script: "cat > swapDate.txt")
		sh (script: "echo ${swapDate}")
		sh (script: "echo ${swapDate} > swapDate.txt")
    }
}
