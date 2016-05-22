###################################
IMPORTANT
###################################

The server running this script must allow external FTP connections
if you intend to allow connection to external servers.

###################################
SUPPORT
###################################

Support Portal:
http://www.monstaftp.com/support

FAQ:
http://www.monstaftp.com/support/faq

How To:
http://www.monstaftp.com/support/howto

Troubleshooting:
http://www.monstaftp.com/support/troubleshooting

Contact us:
http://www.monstaftp.com/support/contact

###################################
INSTALL
###################################

Unzip the contents of the Monsta FTP install zip to your desktop.
Then upload the "mftp” folder (and its contents) to your web space.
You'll then access Monsta FTP in your browser from the URL:

www.yourdomain.com/mftp

###################################
CONFIGURATION
###################################

$ftpHost
Enter the host address/port/mode if it should always be a fixed host 
address. Leave this blank if you want the user to input their host address.

$ftpPort
21 is the default

$ftpMode
1 for passive, 0 for not passive (passive is default)

$ftpSSL
1 for SSL, 0 for not SSL - your server must support ftp_ssl_connect()
 
$ftpDir
Enter an FTP server path for the default login (or leave blank for home)

$serverTmp
If left blank, this will be the server’s TMP folder (e.g. /tmp). If setting 
your own, make sure to CHMOD 777 the folder.

$editableExts
A list of file types that can be edited in the text editor

$sessionName
Set the session name, to isolate Monsta FTP from other PHP web apps that
may also use the same/default session name. Must be alphanumeric, and must 
contain at least one alpha character. A blank or invalid setting for 
$sessionName sets the session name to “monstaftp”.

$dateFormatUsa
USA date format - 1 for mm/dd/yy, 0 for dd/mm/yy

$lockOutTime
The number of minutes to lockout 3 consecutive invalid logins

$versionCheck
1 to check Monsta FTP server for updates, 0 to not

$showAdvOption
1 to show advanced interface option at login, 0 to set basic

$showLockSess
1 to show option to lock session to IP, 0 to hide

$showHostInfo
1 to show host address in info box, 0 to hide

$showAddons
1 to show unlicensed addons, 0 to hide

$showDotFiles
1 to show files starting with a dot (system files), 0 to hide

