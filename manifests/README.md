# Directory to manage deployments

`helm.mk` contains common targets(goals) and imported in each directory

    ! Attention!
    Previous iteration used port forwarding, but this way is painfull to maintain.
    
    The current way to access services is via Ingress and `minikube tunnel` command
