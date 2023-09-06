require_relative '../lib/export_data'
require 'axlsx'
require 'roo'

class User
  attr_accessor :name, :email, :age
  
  def initialize(name, email, age)
    @name = name
    @email = email
    @age = age
  end
  
  def attributes
    { name: @name, email: @email, age: @age }
  end
end

RSpec.describe DataExport::Exporter do
  describe '.export_to_csv' do
    context 'when given an array of objects' do
      let(:objects) do
        [
          User.new('User1', 'user1@example.com', 25),
          User.new('User2', 'user2@example.com', 30)
        ]
      end
      let(:file_path) { 'test.csv' }
      
      it 'exports data to a CSV file' do
        DataExport::Exporter.export_to_csv(objects, file_path)
        
        # Assertions to check if the CSV file was created and contains the expected data.
        csv_data = CSV.read(file_path)
        expect(csv_data.size).to eq(3) # Including the header row
        expect(csv_data[0]).to eq(['name', 'email', 'age']) # Header row
        expect(csv_data[1]).to eq(['User1', 'user1@example.com', '25']) # Data row 1
        expect(csv_data[2]).to eq(['User2', 'user2@example.com', '30']) # Data row 2
      end
    end
    
    context 'when given an empty array' do
      let(:objects) { [] }
      let(:file_path) { 'spec/fixtures/empty.csv' } # Use an existing file path
      
      it 'outputs a message and does not create a file' do
        expect { DataExport::Exporter.export_to_csv(objects, file_path) }.to output("No objects to export.\n").to_stdout
      end
    end
    
    context 'when an error occurs during CSV export' do
      let(:objects) { [{ name: 'User1' }] }
      let(:file_path) { '/nonexistent_directory/test.csv' }
      
      it 'outputs an error message' do
        expect { DataExport::Exporter.export_to_csv(objects, file_path) }.to output(/An error occurred while exporting to CSV/).to_stdout
      end
    end
	  
  end
  
  describe '.export_to_text' do
    context 'when given an array of objects' do
      let(:objects) do
        [
          User.new('User1', 'user1@example.com', 25),
          User.new('User2', 'user2@example.com', 30)
        ]
      end
      let(:file_path) { 'test.txt' }
      
      it 'exports data to a text file' do
        DataExport::Exporter.export_to_text(objects, file_path)
        
        # Assertions to check if the text file was created and contains the expected data.
        text_data = File.read(file_path).split("\n")
        expect(text_data.size).to eq(2) # Number of data lines
        expect(text_data[0]).to eq('User1	user1@example.com	25') # Data line 1
        expect(text_data[1]).to eq('User2	user2@example.com	30') # Data line 2
      end
    end
    
    context 'when given an empty array' do
      let(:objects) { [] }
      let(:file_path) { 'spec/fixtures/empty.txt' } # Use an existing file path
      
      it 'outputs a message and does not create a file' do
        expect { DataExport::Exporter.export_to_text(objects, file_path) }.to output("No objects to export.\n").to_stdout
      end
    end
    
    context 'when an error occurs during text export' do
      let(:objects) { [{ name: 'User1' }] }
      let(:file_path) { '/nonexistent_directory/test.txt' }
      
      it 'outputs an error message' do
        expect { DataExport::Exporter.export_to_text(objects, file_path) }.to output(/An error occurred while exporting to text/).to_stdout
      end
    end
    
    # Add more contexts and examples to cover other scenarios and edge cases.
  end
  
  describe '.export_to_xls' do
    let(:user1) { double('User', attributes: { id: 1, name: 'John', email: 'john@example.com' }) }
    let(:user2) { double('User', attributes: { id: 2, name: 'Jane', email: 'jane@example.com' }) }
    let(:objects) { [user1, user2] }
    let(:file_path) { 'users.xlsx' } # Adjust the path as needed
    
    it 'exports data to an XLSX file' do
      # Ensure that the XLSX file does not already exist
      File.delete(file_path) if File.exist?(file_path)
      
      # Call the export_to_xls method
      DataExport::Exporter.export_to_xls(objects, file_path)
      
      # Verify that the XLSX file was created
      expect(File.exist?(file_path)).to be true
      
      # Read the XLSX file and validate its content
      xlsx = Roo::Excelx.new(file_path)
      expect(xlsx.cell(1, 1)).to eq 'id'
      expect(xlsx.cell(1, 2)).to eq 'name'
      expect(xlsx.cell(1, 3)).to eq 'email'
      expect(xlsx.cell(2, 1)).to eq 1
      expect(xlsx.cell(2, 2)).to eq 'John'
      expect(xlsx.cell(2, 3)).to eq 'john@example.com'
      expect(xlsx.cell(3, 1)).to eq 2
      expect(xlsx.cell(3, 2)).to eq 'Jane'
      expect(xlsx.cell(3, 3)).to eq 'jane@example.com'
      
      # Clean up: Delete the generated XLSX file
      File.delete(file_path)
    end
  end
	
end