# frozen_string_literal: true
require 'spec_helper'

RSpec.describe LibyuiClient, :type => :aruba do
  after(:each) do
#    LibyuiClient.wait_finished_app
#    LibyuiClient.kill_app
  end
  context "Running non-destructive scenarios:" do
    it "yast2 host" do
      LibyuiClient.start_app('/usr/sbin/yast2 host')
      LibyuiClient.check_api_version
      #LibyuiClient.attach('localhost', 14155)
      LibyuiClient.find_widget(id: 'wizard', debug_label: 'Host Configuration')
      LibyuiClient.find_widget(id: 'add').click
      LibyuiClient.find_widget(type: 'YDialog', inner_type: 'popup')
      input_host = LibyuiClient.find_widget(id: 'host')
      expect(input_host.type('192.168.3.3').value).to eq('192.168.3.3')
      input_hostname = LibyuiClient.find_widget(id: 'name')
      expect(input_hostname.type('awesome.hostname').value).to eq('awesome.hostname')
      input_aliases = LibyuiClient.find_widget(id: 'aliases')
      expect(input_aliases.type('aliases.hostname').value).to eq('aliases.hostname')
      LibyuiClient.find_widget(id: 'ok').click
      table = LibyuiClient.find_widget(id: 'table')
      table.select_row(value: '192.168.3.3')
      LibyuiClient.find_widget(id: 'delete').click
      # TODO: check for error when implemented in libyui-rest-api
      table.select_row(value: '192.168.3.3') 
      LibyuiClient.find_widget(id: 'abort').click
      LibyuiClient.find_widget(id: 'yes').click
      expect("/etc/hosts")
        .to have_file_content(/^127.0.0.1\s+localhost$/)
        .and have_file_content(/^::1\s+localhost\s+ipv6-localhost ipv6-loopback$/)
        .and have_file_content(/^fe00::0\s+ipv6-localnet$/)
        .and have_file_content(/^ff00::0\s+ipv6-mcastprefix$/)
        .and have_file_content(/^ff02::1\s+ipv6-allnodes$/)
        .and have_file_content(/^ff02::2\s+ipv6-allrouters$/)
        .and have_file_content(/^ff02::3\s+ipv6-allhosts$/)
      expect("/etc/hosts").not_to have_file_content(/192.168.3.3/)
    end
  end
#  it 'select ComboBox item and toggles CheckBox in yast2 bootloader module' do
#    LibyuiClient.start_app('/usr/sbin/yast2 bootloader')
#    #LibyuiClient.attach('localhost', 14155)
#    LibyuiClient.find_widget(id: 'wizard', debug_label: 'Boot Loader Settings')
#    combo = LibyuiClient.find_widget(id: '"Bootloader::LoaderTypeWidget"')
#    expect(combo.select('GRUB2 for EFI').value).to eq('GRUB2 for EFI')
#    check = LibyuiClient.find_widget(id: 'boot')
#    expect(check.toggle.value).to be true
#  end
#  it 'select RadioButton in yast2 lan' do
#    #LibyuiClient.start_app('/usr/sbin/yast2 lan')
#    LibyuiClient.attach('localhost', 14155)
#    radio_tap = LibyuiClient.find_widget(id: '"tap"')
#    expect(radio_tap.select.value).to be true
#  end
end
