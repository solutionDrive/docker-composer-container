composer_version = attribute(
    'composer_version',
    description: 'composer version'
)

control 'composer' do
    impact 1.0
    title 'verifies composer exists'
    desc '
        In order to work with this container
        composer should be usable
    '

    describe command('composer') do
        it { should exist }
    end

    describe command('composer -v') do
        its('exit_status') { should eq 0 }
        its('stdout') { should include 'Composer version ' + composer_version.to_s }
    end
end
