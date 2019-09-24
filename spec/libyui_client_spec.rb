# frozen_string_literal: true

RSpec.describe LibyuiClient do
  it 'has a version number' do
    expect(LibyuiClient::VERSION).not_to be nil
  end
  
  it 'writes IP Address, Hostname and Host Aliases to /etc/hosts' do
    LibyuiClient.start_app('/usr/sbin/yast2 host')
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
    #table.select_row(value: 'awesome.hostname', column: '1')
    LibyuiClient.find_widget(id: 'next').click
    # TODO: check with aruba content of file
  end
  it 'select ComboBox item and toggles CheckBox in yast2 bootloader module' do
    LibyuiClient.start_app('/usr/sbin/yast2 bootloader')
    #LibyuiClient.attach('localhost', 14155)
    LibyuiClient.find_widget(id: 'wizard', debug_label: 'Boot Loader Settings')
    combo = LibyuiClient.find_widget(id: '"Bootloader::LoaderTypeWidget"')
    expect(combo.select('GRUB2 for EFI').value).to eq('GRUB2 for EFI')
    check = LibyuiClient.find_widget(id: 'boot')
    expect(check.toggle.value).to be true
  end
  it 'select RadioButton in yast2 lan' do
    #LibyuiClient.start_app('/usr/sbin/yast2 lan')
    LibyuiClient.attach('localhost', 14155)
    radio_tap = LibyuiClient.find_widget(id: '"tap"')
    expect(radio_tap.select.value).to be true
  end
end

