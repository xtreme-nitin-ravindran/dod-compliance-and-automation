control 'VCLD-70-000019' do
  title 'VAMI must set the encoding for all text Multipurpose Internet Mail Extensions (MIME) types to UTF-8.'
  desc "Invalid user input occurs when a user inserts data or characters into a hosted application's data entry field and the hosted application is unprepared to process that data. This results in unanticipated application behavior, potentially leading to an application compromise. Invalid user input is one of the primary methods employed when attempting to compromise an application.

An attacker can also enter Unicode into hosted applications in an effort to break out of the document home or root home directory or to bypass security checks."
  desc 'check', %q[At the command prompt, run the following command:

# /opt/vmware/sbin/vami-lighttpd -p -f /opt/vmware/etc/lighttpd/lighttpd.conf 2>/dev/null|awk '/mimetype\.assign/,/\\)/'|grep "text/"|grep -v "charset=utf-8"|sed -e 's/^[ ]*//'

If the command returns any value, this is a finding.

Note: The command must be run from a bash shell and not from a shell generated by the "appliance shell". Use the "chsh" command to change the shell for the account to "/bin/bash". Refer to KB Article 2100508 for more details:

https://kb.vmware.com/s/article/2100508]
  desc 'fix', 'Navigate to and open:

/opt/vmware/etc/lighttpd/lighttpd.conf

Navigate to the "mimetype.assign" block.

Replace all the mappings whose assigned type is "text/*" with mappings for UTF-8 encoding. For example:

  ".log"          =>      "text/plain; charset=utf-8",
  ".conf"         =>      "text/plain; charset=utf-8",
  ".text"         =>      "text/plain; charset=utf-8",
  ".txt"          =>      "text/plain; charset=utf-8",
  ".spec"         =>      "text/plain; charset=utf-8",
  ".dtd"          =>      "text/xml; charset=utf-8",
  ".xml"          =>      "text/xml; charset=utf-8",

Restart the service with the following command:

# vmon-cli --restart applmgmt'
  impact 0.5
  tag check_id: 'C-60338r888509_chk'
  tag severity: 'medium'
  tag gid: 'V-256663'
  tag rid: 'SV-256663r888511_rule'
  tag stig_id: 'VCLD-70-000019'
  tag gtitle: 'SRG-APP-000251-WSR-000157'
  tag fix_id: 'F-60281r888510_fix'
  tag cci: ['CCI-001310']
  tag nist: ['SI-10']

  describe command("/opt/vmware/sbin/vami-lighttpd -p -f /opt/vmware/etc/lighttpd/lighttpd.conf 2>/dev/null|awk '/mimetype\\.assign/,/\\)/'|grep \"text/\"|grep -v \"charset=utf-8\"|sed -e 's/^[ ]*//'") do
    its('stdout') { should cmp '' }
  end
end
