#!/usr/bin/perl
use CGI qw(:standard);

use Linux::usermod;
use File::Copy;
use DynGig::Util::Setuid;
use File::Copy::Recursive;
use File::Path;

 
DynGig::Util::Setuid->sudo( 'root' );

#Recogida de argumentos
my $_nick;
$_nick = param('nick');
my $_email;
$_email = param('email');
my $_password;
$_password = param('password');


#Creacción de la cuenta del usuario Moodle

chdir "/var/www/moodle/";
system("moosh -n user-create --city Salamanca --country ES --password ".$_password." --email ".$_email." ".$_nick);
