# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Net-Abuse-Util.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 8;
BEGIN { use_ok('Net::Abuse::Utils') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

use Net::Abuse::Utils qw ( :all );

# these depend on network access, silly I know
# future versions will override the modules used by Net::Abuse::Utils
# to hand it static data

my $ip = '67.18.92.99';

ok ( get_abusenet_contact('linode.com') eq 'abuse@linode.com', 'abuse.net lookup'   );
ok ( get_soa_contact($ip)               eq 'dns@linode.com',   'soa contact'        );
ok ( get_ip_country($ip)                eq 'US',               'IP Country lookup'  );
ok ( (get_asn_info($ip))[0]             eq '21844',            'ASN from IP'        );
ok ( get_as_description(21844)          eq 'THE PLANET',       'AS Description'     );

ok (
    get_dnsbl_listing('127.0.0.2', 'bl.spamcop.net')
    eq 'Blocked - see http://www.spamcop.net/bl.shtml?127.0.0.2',
    'DNSBL listing check'
);

like ( join(' ',get_ipwi_contacts('67.18.92.99')), qr/\w+@\w+/, 'whois contacts');

