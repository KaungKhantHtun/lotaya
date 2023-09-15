1. ssh -i ~/.ssh/hackathon_instance_3.pem ec2-user@52.76.200.229 (local terminal)
2. scp -i ~/.ssh/hackathon_instance_3.pem -r /Users/kaungkhanthtoonm1/Development/Hackathon/hakathon_service/build/web/ ec2-user@52.76.200.229:/home/ec2-user/ (local terminal)
3. mv ~/web/* /var/www/html/  (remote terminal)
