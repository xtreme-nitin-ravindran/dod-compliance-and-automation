control 'PHTN-30-000036' do
  title 'The Photon operating system must use Transmission Control Protocol (TCP) syncookies.'
  desc "A TCP SYN flood attack can cause a denial of service by filling a system's TCP connection table with connections in the SYN_RCVD state. Syncookies can be used to track a connection when a subsequent ACK is received, verifying the initiator is attempting a valid connection and is not a flood source. This feature is activated when a flood condition is detected and enables the system to continue servicing valid connection requests.

"
  desc 'check', 'At the command line, run the following command:

# /sbin/sysctl -a --pattern tcp_syncookies

Expected result:

net.ipv4.tcp_syncookies = 1

If the output does not match the expected result, this is a finding.'
  desc 'fix', 'At the command line, run the following commands:

# sed -i -e "/^net.ipv4.tcp_syncookies/d" /etc/sysctl.conf
# echo net.ipv4.tcp_syncookies=1>>/etc/sysctl.conf
# /sbin/sysctl --load'
  impact 0.5
  tag check_id: 'C-60187r887208_chk'
  tag severity: 'medium'
  tag gid: 'V-256512'
  tag rid: 'SV-256512r887210_rule'
  tag stig_id: 'PHTN-30-000036'
  tag gtitle: 'SRG-OS-000142-GPOS-00071'
  tag fix_id: 'F-60130r887209_fix'
  tag satisfies: ['SRG-OS-000142-GPOS-00071', 'SRG-OS-000420-GPOS-00186']
  tag cci: ['CCI-001095', 'CCI-002385']
  tag nist: ['SC-5 (2)', 'SC-5 a']

  describe kernel_parameter('net.ipv4.tcp_syncookies') do
    its('value') { should eq 1 }
  end
end
