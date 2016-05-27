# A&H Software Solution's DiaWeb 2.0

- **cgi-bin** -> Contains the Perl administrative Scripts that are called by the Django app & doesn't require special permissions. It also contains the neccesary css/js to visualize the html response if needed.
- **cgi** -> Contains the Perl scripts that need root permissions to run. They are isolated from the cgi-bin scripts for security reasons. (so they can't be called by a post request to the Apache web server)
- **configFiles** -> contains relevant config files
- **cronScripts** -> contains the .sh scripts used to generate daily backups and reports with the help of cron.
- **skel** -> /etc/skel contains the files used when creating a new user (or when activating the blog of an user)
- **var** -> Contains www (Bootstrap front-end + most of the "apps") & the DjApp (the Django app)


Copyright: Alberto González San Juan & Héctor Gonzalo Andrés 2016

