php_version = attribute(
    'php_version',
    description: 'php version'
)

control 'php' do
    impact 1.0
    title 'verifies php exists'
    desc '
        In order to work with this container
        php should be usable
    '

    describe command('php') do
        it { should exist }
    end

    describe command('php -v') do
        its('exit_status') { should eq 0 }
        its('stdout') { should include 'PHP ' + php_version.to_s }
    end

    describe command('php -i | grep ini') do
        its('exit_status') { should eq 0 }
        its('stdout') { should include 'memory-limit.ini'}
    end

    describe command('php -i | grep memory_limit') do
        its('exit_status') { should eq 0 }
        its('stdout') { should include 'memory_limit'}
        its('stdout') { should include '2536M' }
    end
end
