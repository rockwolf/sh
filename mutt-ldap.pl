#! /usr/bin/perl -Tw
# 2005-02-24: Fixed for AD/Exchange 2003 & Unicode characters,
# anders@bsdconsulting.no If you find this script useful, let me know. :-)
#
# 2000/2001: Original version obtained from Andreas Plesner Jacobsen at
# World Online Denmark. Worked for me with Exchange versions prior to Exchange
# 2000.
#
# Use it with mutt by putting in your .muttrc:
# set query_command = "/home/user/bin/mutt-ldap.pl '%s'"
#
# Then you can search for your users by name directly from mutt. Press ^t
# after having typed parts of the name. Remember to edit configuration
# variables below.

use strict;
use Encode qw/encode decode/;
use vars qw { $ldapserver $domain $username $password $basedn };

# --- configuration ---
$ldapserver = "127.0.0.1";
$domain = "mafiahideout";
$username = "Manager";
$password = "0p3nld4p";
$basedn = "mafiahideout";
# --- end configuration ---

use Net::LDAP;

#my $search=shift;
my $search=encode("UTF-8", join(" ", @ARGV));

if (!$search=~/[\.\*\w\s]+/) {
	print("Invalid search parameters\n");
	exit 1;
}

my $ldap = Net::LDAP->new($ldapserver, port=>389) or die "$@";

$ldap->bind("cn=$username,o=$domain", password=>$password);

my $mesg = $ldap->search (base => "o=$basedn",
                          filter => "(|(cn=*$search*) (givenName=*$search*) (sn=*$search*) (mail=*$search*))",
                          #filter => "(mail=*$search*)",
			  #attrs => ['mail','cn']
			  );
my @entries = ();
#$mesg->code && die $mesg->error;


#foreach my $entry ($mesg->all_entries) {
#	if ($entry->get_value('mail')) {
#		print($entry->get_value('mail'),"kak\t",
#		      decode("UTF-8", $entry->get_value('cn')),"\tFrom Exchange LDAP database\n");
#		}
#	}
  foreach my $entry ( $mesg->entries() ) {
  my @emailAddr = $entry->get_value('mail');
  foreach my $addr (@emailAddr) {
    push @entries, 
        { email      => $entry->get_value( 'mail' ), 
          first_name => $entry->get_value( 'givenName' ), 
          last_name  => $entry->get_value( 'sn' ) }; 
	 }
  }  
#print(scalar($mesg->all_entries), " entries found\n");
  $ldap->unbind();
  print("\n");
  foreach my $entry ( @entries ) {
    print "$entry->{email}\t$entry->{first_name} $entry->{last_name}\n";
  }  

#$ldap->unbind;
