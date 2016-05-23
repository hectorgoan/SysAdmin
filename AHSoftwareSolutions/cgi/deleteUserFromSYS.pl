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
	#Eliminación de la cuenta del usuario (comprobación del rol para decidir grupo)
	Linux::usermod->del($_nick);
	
	#Eliminación del directorio home
	my $homePath ="/home/" . $_nick . "/";
	rmtree($homePath, 1, 1 );
	
	chdir "/var/www/moodle/";
	system("moosh -n user-delete ".$_nick);
	
}




