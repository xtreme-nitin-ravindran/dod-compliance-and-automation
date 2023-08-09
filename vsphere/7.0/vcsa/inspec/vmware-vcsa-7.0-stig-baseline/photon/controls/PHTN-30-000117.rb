control 'PHTN-30-000117' do
  title 'The Photon operating system must store only encrypted representations of passwords.'
  desc 'Passwords must be protected at all times via strong, one-way encryption. If passwords are not encrypted, they can be plainly read (i.e., clear text) and easily compromised. If they are encrypted with a weak cipher, those passwords are much more vulnerable to offline brute-force attacks.'
  desc 'check', 'At the command line, run the following command:

# grep password /etc/pam.d/system-password|grep --color=always "sha512"

If the output does not include "sha512", this is a finding.'
  desc 'fix', 'Navigate to and open:

/etc/pam.d/system-password

Add the argument "sha512" to the "password" line:

password required pam_unix.so sha512 shadow try_first_pass

Note: On vCenter appliances, the equivalent file must be edited under "/etc/applmgmt/appliance", if one exists, for the changes to persist after a reboot.'
  impact 0.5
  tag check_id: 'C-60260r887427_chk'
  tag severity: 'medium'
  tag gid: 'V-256585'
  tag rid: 'SV-256585r887429_rule'
  tag stig_id: 'PHTN-30-000117'
  tag gtitle: 'SRG-OS-000073-GPOS-00041'
  tag fix_id: 'F-60203r887428_fix'
  tag cci: ['CCI-000196']
  tag nist: ['IA-5 (1) (c)']

  describe file('/etc/pam.d/system-password') do
    its('content') { should match /^(?=.*?\bpassword\b)(?=.*?\brequired\b)(?=.*?\bsha512\b).*$/ }
  end
end
