require 'chefspec'

describe 'apache::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

  it 'installs apache2' do
    resource = chef_run.package('apache2')
    expect(chef_run).to install_package('apache2')
    expect(resource).to notify('apt_update[update]').to(:update).before
    expect(resource).to notify('ohai[reload]').to(:reload).immediately
  end

  it 'upgrades packages' do
    %w(curl htop ntp ruby stress tree vim).each do |pkg|
      expect(chef_run).to upgrade_package(pkg)
    end
  end

  it 'enables services' do
    %w(apache2 ntp).each do |srv|
      expect(chef_run).to enable_service(srv)
      expect(chef_run).to start_service(srv)
    end
  end

  it 'creates template file' do
    resource = chef_run.template('/var/www/html/index.html')
    expect(chef_run).to create_template('/var/www/html/index.html').with(
      owner: 'root',
      group: 'root',
      mode: '0644',
    )
    expect(resource).to notify('package[apache2]').to(:install).before
    expect(resource).to notify('service[apache2]').to(:reload).immediately
  end
end
