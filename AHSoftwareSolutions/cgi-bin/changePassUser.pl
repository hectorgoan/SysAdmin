#!/usr/bin/perl

use warnings;
#use strict;
use CGI qw(:standard);
use Email::Send::SMTP::Gmail;
use IPC::System::Simple qw(run);

#Recogida de argumentos
my $_nick;
$_nick = param('nick');
my $_email;
$_email = param('email');
my $_password;
$_password = param('password');
my $_hash;
$_hash = param('hash');

if ($_hash ne "PasswdSupaSecret") 
{
	die();
}

#Creacción user
	#Se hace necesario llamar al script desde linea de comandos, se intentaron múltiples formas de ejecutarlo (modulos sudo, por ejemplo) 
	#desde terminal funciona, pero llamando desde URL, estos módulos pierden los parámetros por el camino
	my $_parametros = "nick=".$_nick."&email=".$_email."&password=".$_password;
	
	my @args;
	@args = ("/usr/lib/cgi/changePassUserSYS.pl", $_parametros);
	run("perl", @args);

	
#Notificación vía mail
#DUMMY GMAIL ACCOUNT - NOTHING IMPORTANT HERE - REPLACE IT WITH YOUR'S
my ($mail,$error)=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com', 
                                                -login=>'ahsoftsol@gmail.com', 
                                                -pass=>'USALdebian');
                                                
my $message = <<"END_MSG";
Información de recuperación de tu contraseña:

	Nombre de usuario: $_nick
	Contraseña:	$_password
 
Un saludo.
END_MSG

#print "session error: $error" unless ($email!=-1);
$mail->send(-to=>$_email, 
			-subject=>'Bienvenido a DiaWeb 2.0', 
			-body=>$message);

$mail->bye;

