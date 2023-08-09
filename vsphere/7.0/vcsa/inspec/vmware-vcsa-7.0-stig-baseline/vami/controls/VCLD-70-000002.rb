control 'VCLD-70-000002' do
  title 'VAMI must be configured with FIPS 140-2 compliant ciphers for HTTPS connections.'
  desc "Encryption of data in flight is an essential element of protecting information confidentiality. If a web server uses weak or outdated encryption algorithms, the server's communications could be compromised.

The U.S. Federal Information Processing Standards (FIPS) publication 140-2, Security Requirements for Cryptographic Modules (FIPS 140-2), identifies 11 areas for a cryptographic module used inside a security system that protects information. FIPS 140-2 approved ciphers provide the maximum level of encryption possible for a private web server.

VAMI is compiled to use VMware's FIPS-validated OpenSSL module and cannot be configured otherwise. Ciphers may still be specified in order of preference, but no non-FIPS approved ciphers will be implemented.

"
  desc 'check', %q(At the command prompt, run the following command:

# /opt/vmware/sbin/vami-lighttpd -p -f /opt/vmware/etc/lighttpd/lighttpd.conf 2>/dev/null|grep "ssl.cipher-list"|sed -e 's/^[ ]*//'

Expected result:

ssl.cipher-list                   = "!aNULL:kECDH+AESGCM:ECDH+AESGCM:RSA+AESGCM:kECDH+AES:ECDH+AES:RSA+AES"

If the output does not match the expected result, this is a finding.

Note: The command must be run from a bash shell and not from a shell generated by the "appliance shell". Use the "chsh" command to change the shell for the account to "/bin/bash". Refer to KB Article 2100508 for more details:

https://kb.vmware.com/s/article/2100508)
  desc 'fix', 'Navigate to and open:

/etc/applmgmt/appliance/lighttpd.conf

Add or reconfigure the following value:

ssl.cipher-list                   = "!aNULL:kECDH+AESGCM:ECDH+AESGCM:RSA+AESGCM:kECDH+AES:ECDH+AES:RSA+AES"

Restart the service with the following command:

# vmon-cli --restart applmgmt'
  impact 0.7
  tag check_id: 'C-60321r888458_chk'
  tag severity: 'high'
  tag gid: 'V-256646'
  tag rid: 'SV-256646r888460_rule'
  tag stig_id: 'VCLD-70-000002'
  tag gtitle: 'SRG-APP-000014-WSR-000006'
  tag fix_id: 'F-60264r888459_fix'
  tag satisfies: ['SRG-APP-000014-WSR-000006', 'SRG-APP-000416-WSR-000118', 'SRG-APP-000439-WSR-000188']
  tag cci: ['CCI-000068', 'CCI-002418', 'CCI-002450']
  tag nist: ['AC-17 (2)', 'SC-8', 'SC-13 b']

  runtime = command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')}").stdout

  describe parse_config(runtime).params['ssl.cipher-list'] do
    it { should cmp "#{input('sslCipherList')}" }
  end
end
