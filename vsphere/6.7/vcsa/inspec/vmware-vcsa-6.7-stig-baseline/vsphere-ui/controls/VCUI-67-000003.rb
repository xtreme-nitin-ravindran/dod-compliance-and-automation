control "VCUI-67-000003" do
  title "vSphere UI must limit the maximum size of a POST request."
  desc  "The 'maxPostSize' value is the maximum size in bytes of the POST which
will be handled by the container FORM URL parameter parsing. Limit its size to
reduce exposure to a DOS attack. If 'maxPostSize' is not set, the default value
of 2097152 (2MB) is used. Security Token Service is configured in it's shipping
state to not set a value for 'maxPostSize'."
  impact 0.5
  tag severity: "CAT II"
  tag gtitle: "SRG-APP-000266-WSR-000159"
  tag gid: nil
  tag rid: "VCUI-67-000003"
  tag stig_id: "VCUI-67-000003"
  tag cci: "CCI-001312"
  tag nist: ["SI-11 a", "Rev_4"]
  desc 'check', "At the command prompt, execute the following command:

# xmllint --format /usr/lib/vmware-vsphere-ui/server/conf/server.xml | sed '2
s/xmlns=\".*\"//g' |  xmllint --xpath
'/Server/Service/Connector[@port=\"${http.port}\"]/@maxPostSize' -

Expected result:

XPath set is empty

If the output does not match the expected result, this is a finding"
  desc 'fix', "Navigate to and open
/usr/lib/vmware-vsphere-ui/server/conf/server.xml

Navigate to each of the <Connector> nodes.

Remove any configuration for 'maxPostSize'.
"

  describe xml('/usr/lib/vmware-vsphere-ui/server/conf/server.xml') do
    its('Server/Service/Connector/attribute::maxPostSize') { should eq [] }
  end

end