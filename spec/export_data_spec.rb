# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/export_data'

RSpec.describe DataExport::Exporter do
  describe '.export_to_csv' do
    let(:user1) { double('User', attributes: { id: 1, name: 'Alice' }) }
    let(:user2) { double('User', attributes: { id: 2, name: 'Bob' }) }
    let(:objects) { [user1, user2] }
    let(:file_path) { 'spec/fixtures/users.csv' } # Use a fixture path for testing
    
    context 'when exporting data to CSV' do
      it 'creates a CSV file with the correct data' do
        DataExport::Exporter.export_to_csv(objects, file_path)
        
        # Verify that the CSV file was created and contains the expected data
        csv_data = CSV.read(file_path)
        expect(csv_data).to eq([
                                 ['id', 'name'],
                                 ['1', 'Alice'],
                                 ['2', 'Bob']
                               ])
      end
      
      it 'handles an empty objects array gracefully' do
        expect { DataExport::Exporter.export_to_csv([], file_path) }.not_to raise_error
      end
    end
    
    context 'when encountering errors' do
      it 'handles CSV::MalformedCSVError and prints an error message' do
        allow(CSV).to receive(:open).and_raise(CSV::MalformedCSVError.new('Malformed CSV', 'line'))
        
        expect { DataExport::Exporter.export_to_csv(objects, file_path) }
          .to output(/An error occurred while exporting to CSV:/).to_stdout
      end
    end
  end
end