
RSpec.describe LibyuiClient do
  it 'has a version number' do
    expect(LibyuiClient::VERSION).not_to be nil
  end
  it "writes IP Address, Hostname and Host Aliases to /etc/hosts" do
    expect(LibyuiClient.start_app('/usr/sbin/yast2 host')).to be nil
    #expect(LibyuiClient.attach('localhost', 14155)).to be nil 
    expect(LibyuiClient.find_widget_by_id(id: 'wizard', class_name: Wizard).debug_label). to eq 'Host Configuration'
    LibyuiClient.find_widget_by_id(id: 'add', class_name: Button).click
    LibyuiClient.find_widget_by_type(class_name: Popup)
    expect(LibyuiClient.find_widget_by_id(id: 'host', class_name: TextBox).type(value: '192.168.3.3').value).to eq("192.168.3.3")
    expect(LibyuiClient.find_widget_by_id(id: 'name', class_name: TextBox).type(value: 'awesome.hostname').value).to eq("awesome.hostname")
    expect(LibyuiClient.find_widget_by_id(id: 'aliases', class_name: TextBox).type(value: 'aliases.hostname').value).to eq("aliases.hostname")
    LibyuiClient.find_widget_by_id(id: 'ok', class_name: Button).click
    table = LibyuiClient.find_widget_by_id(id: 'table', class_name: Table)
    expect(table.header).to contain_exactly('IP Address', 'Hostnames', 'Host Aliases')
    expect(table.search_row('Hostnames': 'awesome.hostname', 'IP Address': '192.168.3.3')).to eq(['192.168.3.3', 'awesome.hostname', 'aliases.hostname'])
    expect(table.search_row('Hostnames': 'localhost')).to eq(['127.0.0.1', 'localhost', ''])
    expect(table.search_row('Host Aliases': 'aliases.hostname', 'Hostnames': 'awesome.hostname', 'IP Address': '192.168.3.3')).to eq (['192.168.3.3', 'awesome.hostname', 'aliases.hostname'])
    LibyuiClient.find_widget_by_id(id: 'next', class_name: Button).click
    # TODO: check with aruba content of file
  end
end
