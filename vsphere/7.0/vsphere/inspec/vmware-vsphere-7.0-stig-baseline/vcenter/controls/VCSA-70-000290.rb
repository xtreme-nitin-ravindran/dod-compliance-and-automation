control 'VCSA-70-000290' do
  title 'The vCenter Server must limit membership to the "SystemConfiguration.BashShellAdministrators" Single Sign-On (SSO) group.'
  desc 'vCenter SSO integrates with PAM in the underlying Photon operating system so members of the "SystemConfiguration.BashShellAdministrators" SSO group can log on to the operating system without needing a separate account. However, even though unique SSO users log on, they are transparently using a group account named "sso-user" as far as Photon auditing is concerned. While the audit trail can still be traced back to the individual SSO user, it is a more involved process.

To force accountability and nonrepudiation, the SSO group "SystemConfiguration.BashShellAdministrators" must be severely restricted.'
  desc 'check', 'From the vSphere Client, go to Administration >> Single Sign On >> Users and Groups >> Groups.

Click the next page arrow until the "SystemConfiguration.BashShellAdministrators" group appears.

Click "SystemConfiguration.BashShellAdministrators".

Review the members of the group and ensure that only authorized accounts are present.

Note: These accounts act as root on the Photon operating system and have the ability to severely damage vCenter, inadvertently or otherwise.

If there are any accounts present as members of SystemConfiguration.BashShellAdministrators that are not authorized, this is a finding.'
  desc 'fix', 'From the vSphere Client, go to Administration >> Single Sign On >> Users and Groups >> Groups.

Click the next page arrow until the "SystemConfiguration.BashShellAdministrators" group appears.

Click "SystemConfiguration.BashShellAdministrators".

Click the three vertical dots next to the name of each unauthorized account.

Select "Remove Member".'
  impact 0.5
  tag check_id: 'C-60045r885719_chk'
  tag severity: 'medium'
  tag gid: 'V-256370'
  tag rid: 'SV-256370r885721_rule'
  tag stig_id: 'VCSA-70-000290'
  tag gtitle: 'SRG-APP-000516'
  tag fix_id: 'F-59988r885720_fix'
  tag cci: ['CCI-000366']
  tag nist: ['CM-6 b']

  bashShellAdminUsers = input('bashShellAdminUsers')
  users = powercli_command('Get-SsoGroup -Domain vsphere.local -Name SystemConfiguration.BashShellAdministrators | Get-SsoPersonUser | Select-Object -ExpandProperty Name')
  if users.stdout.empty?
    describe 'Stderr should be empty if no users found' do
      subject { users.stderr }
      it { should be_empty }
    end
    describe 'No users found in SystemConfiguration.BashShellAdministrators' do
      subject { users.stdout }
      it { should be_empty }
    end
  else
    users.stdout.gsub("\r\n", "\n").split("\n").each do |user|
      describe user do
        it { should be_in bashShellAdminUsers }
      end
    end
  end
  bashShellAdminGroups = input('bashShellAdminGroups')
  groups = powercli_command('Get-SsoGroup -Domain vsphere.local -Name SystemConfiguration.BashShellAdministrators | Get-SsoGroup | Select-Object -ExpandProperty Name')
  if groups.stdout.empty?
    describe 'Stderr should be empty if no groups found' do
      subject { groups.stderr }
      it { should be_empty }
    end
    describe 'No groups found in SystemConfiguration.BashShellAdministrators' do
      subject { groups.stdout }
      it { should be_empty }
    end
  else
    groups.stdout.gsub("\r\n", "\n").split("\n").each do |group|
      describe group do
        it { should be_in bashShellAdminGroups }
      end
    end
  end
end
