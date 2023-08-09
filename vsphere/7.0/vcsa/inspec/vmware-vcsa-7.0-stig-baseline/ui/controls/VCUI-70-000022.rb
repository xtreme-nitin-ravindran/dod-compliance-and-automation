control 'VCUI-70-000022' do
  title 'vSphere UI must set the welcome-file node to a default web page.'
  desc %q(Enumeration techniques, such as URL parameter manipulation, rely on being able to obtain information about the web server's directory structure by locating directories without default pages. In this scenario, the web server will display to the user a listing of the files in the directory being accessed.

By having a default hosted application web page, the anonymous web user will not obtain directory browsing information or an error message that reveals the server type and version. Ensuring every document directory has an "index.jsp" (or equivalent) file is one approach to mitigating the vulnerability.)
  desc 'check', %q(At the command prompt, run the following command:

# xmllint --format /usr/lib/vmware-vsphere-ui/server/conf/web.xml | sed 's/xmlns=".*"//g' | xmllint --xpath '/web-app/welcome-file-list' -

Expected result:

<welcome-file-list>
  <welcome-file>index.html</welcome-file>
  <welcome-file>index.htm</welcome-file>
  <welcome-file>index.jsp</welcome-file>
</welcome-file-list>

If the output of the command does not match the expected result, this is a finding.)
  desc 'fix', 'Navigate to and open:

/usr/lib/vmware-vsphere-ui/server/conf/web.xml

Add the following section under the <web-apps> node:

<welcome-file-list>
  <welcome-file>index.html</welcome-file>
  <welcome-file>index.htm</welcome-file>
  <welcome-file>index.jsp</welcome-file>
</welcome-file-list>

Restart the service with the following command:

# vmon-cli --restart vsphere-ui'
  impact 0.5
  tag check_id: 'C-60474r889394_chk'
  tag severity: 'medium'
  tag gid: 'V-256799'
  tag rid: 'SV-256799r889396_rule'
  tag stig_id: 'VCUI-70-000022'
  tag gtitle: 'SRG-APP-000266-WSR-000142'
  tag fix_id: 'F-60417r889395_fix'
  tag cci: ['CCI-001312']
  tag nist: ['SI-11 a']

  list = ['index.jsp', 'index.html', 'index.htm']
  describe xml("#{input('webXmlPath')}") do
    its('/web-app/welcome-file-list/welcome-file') { should be_in list }
  end
end
