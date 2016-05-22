# Systems Administration
This repository contains a solution to cover the "Departamento de Informática" needs of a new system, proposed by "A&H Software Solutions"

- **www** -> Contains the Bootstrap front-end & the Django app
- **cgi-bin** -> Contains the Perl administrative Scripts that are called by the Django app & doesn't require special permissions. It also contains the neccesary css/js to visualize the html response if needed.
- **cgi** -> Contains the Perl scripts that need root permissions to run. They are isolated from the cgi-bin scripts for security reasons. (so they can't be called by a post request to the Apache web server)
- **skel** -> /etc/skel contains the files used when creating a new user (or when activating the blog of an user)

Copyright: Alberto González San Juan & Héctor Gonzalo Andrés 2016

