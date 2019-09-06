RSpec.describe LibyuiClient do
  it "has a version number" do
    expect(LibyuiClient::VERSION).not_to be nil
  end
  it "launches application '/usr/sbin/yast2 host'" do
    expect(LibyuiClient.start_app("/usr/sbin/yast2 host")).to be nil
  end
	it "checks dialog heading is 'Host Configuration'" do
	  expect(LibyuiClient.check_dialog_heading).to eq "Host Configuration"
	end
	it "clicks on button 'add'" do
	  expect(LibyuiClient.click_button(id: "add")).to be nil
	end
	it "displays a pop-up" do
	  expect(LibyuiClient.is_popup_displayed).to be nil
	end
end
