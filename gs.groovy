
// build(DockerHub Profile/imageName , version , credentialId from jenkins , Dockerfile path)
def build(String imageName ,String version ,String credId ,String dockerfilelocation){
    withCredentials([
        usernamePassword(
            credentialsId: "$credId",
            usernameVariable: "USER",
            passwordVariable: "PASSWORD"
        )
    ]){
        sh "docker build $dockerfilelocation -t $imageName:$version"
        sh "echo $PASSWORD | docker login -u $USER --password-stdin"
        sh "docker push $imageName:$version"
    }
}
// build(remote user name , remote Ip@ , credentialId from jenkins , github repo url , full script path : Repo-name/Path-to-scrip/Script-name )
def deploy(String remote_user ,String remote_ip ,String version ,String credId ,String repo ,String script_path){
    sshagent(credentials:["$credId"]){
        sh """
            ssh -o StrictHostKeyChecking=no $remote_user@$remote_ip <<EOF
                rm -rf jenkins # remove old repofiles
                mkdir jenkins ; cd jenkins ; git clone $repo # clone repo in jenkins folder
                sudo chmod +x $script_path # add execute permissions
                sh $script_path -v $version# run script
        """
    }
}

return this