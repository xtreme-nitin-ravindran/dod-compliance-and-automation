control 'VRPP-8X-000075' do
  title 'VMware Aria Operations vPostgres must use UTC for log timestamps.'
  desc  "
    If time stamps are not consistently applied and there is no common time reference, it is difficult to perform forensic analysis.

    Time stamps generated by vPostgres must include date and time. Time is commonly expressed in Coordinated Universal Time (UTC), a modern continuation of Greenwich Mean Time (GMT), or local time with an offset from UTC.
  "
  desc  'rationale', ''
  desc  'check', "
    As a database administrator, run the following at the command prompt:

    # su - postgres -c \"/opt/vmware/vpostgres/current/bin/psql -p 5433 -A -t -c \\\"SHOW log_timezone;\\\"\"

    Expected result:

    UTC

    If the output does not match the expected result, this is a finding.
  "
  desc 'fix', "
    As a database administrator, run the following at the command prompt:

    # su - postgres -c \"/opt/vmware/vpostgres/current/bin/psql -p 5433 -c \\\"ALTER SYSTEM SET log_timezone TO 'UTC';\\\"\"

    Reload the vPostgres service by running the following command:

    # systemctl restart vpostgres-repl.service
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000374-DB-000322'
  tag gid: 'V-VRPP-8X-000075'
  tag rid: 'SV-VRPP-8X-000075'
  tag stig_id: 'VRPP-8X-000075'
  tag cci: ['CCI-001890']
  tag nist: ['AU-8 b']

  describe command("su - postgres -c '/opt/vmware/vpostgres/current/bin/psql -p 5433 -A -t -c \"SHOW log_timezone;\"'") do
    its('stdout.strip') { should cmp 'UTC' }
  end
end
