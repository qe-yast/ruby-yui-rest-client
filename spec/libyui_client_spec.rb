RSpec.describe LibyuiClient do
  after(:each) do
    LibyuiClient.add_step_delay  
  end
  it "has a version number" do
    expect(LibyuiClient::VERSION).not_to be nil
  end
  it "launches application '/usr/sbin/yast2 host'" do
    expect(LibyuiClient.start_app("/usr/sbin/yast2 host")).to be nil
  end
	it "checks dialog heading is 'Host Configuration'" do
	  expect(LibyuiClient.check_dialog_heading).to eq "Host Configuration"
	end
	it "clicks on button 'Add'" do
	  expect(LibyuiClient.click_button(id: "add")).to be nil
	end
	it "displays a pop-up" do
	  expect(LibyuiClient.is_popup_displayed).to be nil
	end
  it "fills in IP Address input with '192.168.3.3'" do
	  expect(LibyuiClient.type_text(id: "host", value: "192.168.3.3")).to be nil
	end
  it "fills in Hostname input with 'awesome.hostname'" do
	  expect(LibyuiClient.type_text(id: "name", value: "awesome.hostname")).to be nil
	end
  it "fills in Host Aliases input with 'cool.hostname'" do
	  expect(LibyuiClient.type_text(id: "aliases", value: "cool.hostname")).to be nil
	end
	it "clicks on button 'OK'" do
	  expect(LibyuiClient.click_button(id: "ok")).to be nil
	end
	it "checks row added containing '192.168.3.3'" do
	  expect(LibyuiClient.check_table_row(value: "192.168.3.3")).to be nil
	end
	it "clicks on button 'OK'" do
	  expect(LibyuiClient.click_button(id: "next")).to be nil
	end
  it "runs command to check new hostname is added to /etc/hosts" do
    expect(LibyuiClient.run_command(command: "grep '^192.168.3.3.*awesome.hostname.*cool.hostname$' /etc/hosts > /dev/null")).to be nil
  end
end
