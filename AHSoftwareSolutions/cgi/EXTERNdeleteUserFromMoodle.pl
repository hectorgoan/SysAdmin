#!/usr/bin/perl
use CGI qw(:standard);

use Linux::usermod;
use File::Path;
use DynGig::Util::Setuid;
 
DynGig::Util::Setuid->sudo( 'root' );

#Recogida de argumentos
my $_nick;
$_nick = param('nick');

if (length($_nick) != 0) 
{
	#Eliminación de la cuenta del usuario Moodle

	chdir "/var/www/moodle/";
	system("moosh -n user-delete ".$_nick);
	
}




