# FlightsDistance
Getting Started

Open a new Terminal (Mac) or Command Prompt (Windows) window and use the following command to create a unique directory: mkdir FlightsDistance cd FlightsDistance

Clone the git repo using the following command: git clone https://github.com/rzeeshanahmed/FlightsDistance

Open the directory created in VS Code and connect to the deployment Salesforce Org

Deploy the code using the commands below in the following order: 

sfdx force:source:deploy -p force-app/main/default/objects 
sfdx force:source:deploy -p force-app/main/default/classes 
sfdx force:source:deploy -p force-app/main/default/Pages 
sfdx force:source:deploy -p force-app/main/default/tabs

Give access to user of all the components 
