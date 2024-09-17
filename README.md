# First Step
Deploy Backend Service from Cilist folder first with "devops" as namespace,

 `kubectl apply -f Serpis.yaml -n devops --create-namespace`
 
 then check that Service with
 
 `kubectl get all -n devops`
 
 After you got the elb aws link from that service, Simply copy-paste it to the template/values.yaml in data-url and save!
 
# Helm Deployment
Next, Deploy it with Helm to "devops" namespace!

 `Helm install chill . -n devops` 
 
 *note: "chill" is my Helm Chart for Cilist Development, as Cilist Web Development and Ingress applied in it*
 
 # Landing Page & Whoami
 Next, go to the other folder "Who" and Deploy with Helm with "lolwho" as Helm Chart, But dont forget to deploy in "devops" namespace..
 
 `Helm install lolwho . -n devops`
 
 # Traefik
 
 add Traefik repo from Helm and Deploy its chart, So you will got the elb link later, after that do a port forward!
 
 `kubectl port-forward (traefik-586b8d6d48-qhv8s) 9000:9000`
 
 *note: qhv8s is my traefik pods*
 
 # After you got the External IP from Traefik Service, 
 Simply copy-paste it to the Route 53 as Endpoint to traffic route with different record name as this deployment contains 3 web deployment (Cilist, Landing Page and Whoami)
 
 # Final Step
 
 Check all the web that you have deployed and good luck :)
