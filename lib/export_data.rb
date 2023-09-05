# frozen_string_literal: true

require_relative "export_data/version"

require "csv"

module DataExport
  class Error < StandardError; end
  
  # Exporter class for handling data exports to CSV
  class Exporter
    # Exports data to a CSV file.
    #
    # This method takes an array of objects and exports them to a CSV file
    # specified by the `file_path`. It expects that the first object in the
    # array defines the column names for the CSV file.
    #
    # @param objects [Array] The objects to export to CSV.
    # @param file_path [String] The path to the CSV file to be created.
    #
    # @example Export user data to CSV:
    #   objects = [user1, user2]
    #   DataExport::Exporter.export_to_csv(objects, 'users.csv')
    #
    # @return [void]
    def self.export_to_csv(objects, file_path)
      begin
        CSV.open(file_path, 'w') do |csv|
          if objects.empty?
            puts 'No objects to export.' # Or handle this case as needed
            return
          end
          
          # Write the header row using the first object's attributes
          csv << objects.first.attributes.keys
          
          # Write the object's attribute values as data rows
          objects.each do |obj|
            csv << obj.attributes.values
          end
        end
      rescue CSV::MalformedCSVError => e
        puts "An error occurred while exporting to CSV: #{e.message}"
      rescue Errno::ENOENT => e
        puts "An error occurred while exporting to CSV: #{e.message}"
      end
    end
    
    def self.export_to_text(objects, file_path)
      begin
        File.open(file_path, 'w') do |file|
          if objects.empty?
            puts 'No objects to export.' # Or handle this case as needed
            return
          end
          
          # Write the object's attribute values as text lines
          objects.each do |obj|
            file.puts(obj.attributes.values.join("\t")) # Use '\t' as a delimiter for tab-separated values
          end
        end
      rescue Errno::ENOENT => e
        puts "An error occurred while exporting to text: #{e.message}"
      end
    end
    
  end
end