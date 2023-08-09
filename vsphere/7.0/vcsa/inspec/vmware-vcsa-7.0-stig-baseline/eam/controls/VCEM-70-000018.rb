control 'VCEM-70-000018' do
  title 'ESX Agent Manager must fail to a known safe state if system initialization fails, shutdown fails, or aborts fail.'
  desc 'Determining a safe state for failure and weighing that against a potential denial of service for users depends on what type of application the web server is hosting. For the ESX Agent Manager, it is preferable that the service abort startup on any initialization failure rather than continuing in a degraded, and potentially insecure, state.'
  desc 'check', 'At the command line, run the following command:

# grep EXIT_ON_INIT_FAILURE /etc/vmware-eam/catalina.properties

Expected result:

org.apache.catalina.startup.EXIT_ON_INIT_FAILURE=true

If the output of the command does not match the expected result, this is a finding.'
  desc 'fix', 'Navigate to and open:

/etc/vmware-eam/catalina.properties

Add or change the following line:

org.apache.catalina.startup.EXIT_ON_INIT_FAILURE=true

Restart the service with the following command:

# vmon-cli --restart eam'
  impact 0.5
  tag check_id: 'C-60365r888624_chk'
  tag severity: 'medium'
  tag gid: 'V-256690'
  tag rid: 'SV-256690r888626_rule'
  tag stig_id: 'VCEM-70-000018'
  tag gtitle: 'SRG-APP-000225-WSR-000140'
  tag fix_id: 'F-60308r888625_fix'
  tag cci: ['CCI-001190']
  tag nist: ['SC-24']

  describe parse_config_file("#{input('catalinaPropertiesPath')}").params['org.apache.catalina.startup.EXIT_ON_INIT_FAILURE'] do
    it { should eq 'true' }
  end
end
