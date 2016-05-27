#!/usr/bin/perl

use strict;
use warnings;
use CGI qw(:standard);
use Email::Send::SMTP::Gmail;

my $password;
$password = param('password');
my $email; 
$email = param('email');
my $nick;
$nick = param('nick');
my $_hash;
$_hash = param('hash');

if ($_hash ne "PasswdSupaSecret") 
{
	die();
}
my ($mail,$error)=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com', 
                                                -login=>'ahsoftsol@gmail.com', 
                                                -pass=>'USALdebian');
my $message = <<"END_MSG";
Nueva información de inicio de sesión:

	Nombre de usuario: $nick
	Contraseña:	$password
 
Un saludo.
END_MSG

#print "session error: $error" unless ($email!=-1);

$mail->send(-to=>$email, 
			-subject=>'Bienvenido a DiaWeb 2.0', 
			-body=>$message);

$mail->bye;


#QUERY_STRING="m=2&n=4" ./mult.cgi


