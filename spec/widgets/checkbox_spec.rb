# frozen_string_literal: true

require 'rspec'

module LibyuiClient
  module Widgets
    RSpec.describe Checkbox do
      include_context 'WidgetsCommon'

      # Request/Response parts
      let(:query_toggle) { { query: id.merge(action: 'toggle') } }
      let(:query_check) { { query: id.merge(action: 'check') } }
      let(:query_uncheck) { { query: id.merge(action: 'uncheck') } }
      let(:checked_checkbox) { { body: '[{"value":true}]' } }
      let(:unchecked_checkbox) { { body: '[{"value":false}]' } }

      # Stubbed Requests
      let(:toggle_existing_checkbox) { stub_post.with(query_toggle) }
      let(:toggle_non_existent_checkbox) { stub_post_404.with(query_toggle) }
      let(:check_existing_checkbox) { stub_post.with(query_check) }
      let(:check_non_existent_checkbox) { stub_post_404.with(query_check) }
      let(:uncheck_existing_checkbox) { stub_post.with(query_uncheck) }
      let(:uncheck_non_existent_checkbox) { stub_post_404.with(query_uncheck) }
      let(:get_checked_checkbox) { stub_get_id.to_return(checked_checkbox) }
      let(:get_unchecked_checkbox) { stub_get_id.to_return(unchecked_checkbox) }

      describe '#toggle' do
        context 'existing widget' do
          it 'should succeed' do
            toggle_existing_checkbox
            @app.checkbox(id).toggle
            expect(toggle_existing_checkbox).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            toggle_non_existent_checkbox
            expect { @app.checkbox(id).toggle }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#check' do
        context 'existing widget' do
          it 'should succeed' do
            check_existing_checkbox
            @app.checkbox(id).check
            expect(check_existing_checkbox).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            check_non_existent_checkbox
            expect { @app.checkbox(id).check }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#uncheck' do
        context 'existing widget' do
          it 'should succeed' do
            uncheck_existing_checkbox
            @app.checkbox(id).uncheck
            expect(uncheck_existing_checkbox).to have_been_made.once
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            uncheck_non_existent_checkbox
            expect { @app.checkbox(id).uncheck }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end

      describe '#check?' do
        context 'existing widget' do
          context 'checked checkbox' do
            it 'should return true' do
              get_checked_checkbox
              expect(@app.checkbox(id).checked?).to eq(true)
            end
          end
          context 'unchecked checkbox' do
            it 'should return false' do
              get_unchecked_checkbox
              expect(@app.checkbox(id).checked?).to eq(false)
            end
          end
        end
        context 'non-existent widget' do
          it 'should raise WidgetNotFoundError' do
            stub_get_id_404
            expect { @app.checkbox(id).checked? }.to raise_error(Error::WidgetNotFoundError)
          end
        end
      end
    end
  end
end
