
def build(String imageName ,String ver ,String credId ,String dockerfilelocation){
    withCredentials([
        usernamePassword(
            credentialsId: credId,
            usernameVariable: "USER",
            passwordVariable: "PASSWORD"
        )
    ]){
        sh "docker build $dockerfilelocation -t $imageName:$ver"
        sh 'echo PASSWORD | docker login -u USER --password-stdin'
        sh "docker push $imageName:$ver"
    }
}
return this