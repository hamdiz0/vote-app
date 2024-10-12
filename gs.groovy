
def build(String imageName ,String ver ,String credId ,String dockerfilelocation){
    withCredentials([
        usernamePassword(
            credentialsId: "docker-repo",
            usernameVariable: "USER",
            passwordVariable: "PASSWORD"
        )
    ]){
        sh "docker build $dockerfilelocation -t $imageName:$ver"
        sh 'echo PASSWORD | docker login -u USER --password-stdin'
        sh "docker push $imageName:$ver"
        echo "$credId"
    }
}
return this