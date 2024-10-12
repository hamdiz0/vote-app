
def build(String imageName ,String ver ,String credId){
    withCredentials([
        usernamePassword(
            credentialsId: credId,
            usernameVariable: "USER",
            passwordVariable: "PASSWORD"
        )
    ]){
        sh "docker build . -t $imageName:$ver"
        sh 'echo PASSWORD | docker login -u USER --password-stdin'
        sh "docker push $imageName:$ver"
    }
}
return this