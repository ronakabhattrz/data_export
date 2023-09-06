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
    # specified by the `file_path`. It expects that each object's `attributes`
    # method returns a hash of attribute names and values. The method first
    # writes the header row using the attribute names from the first object,
    # and then writes the data rows using the attribute values of each object.
    #
    # @param objects [Array] The objects to export to a CSV file.
    # @param file_path [String] The path to the CSV file to be created.
    #
    # @example Export user data to a CSV file:
    #   objects = [user1, user2]
    #   DataExport::Exporter.export_to_csv(objects, 'users.csv')
    #
    # @return [void]
    #
    # @note If the `objects` array is empty, this method will output a message and
    #   not create a file.
    # @raise [CSV::MalformedCSVError] If an error occurs while writing to the CSV file,
    #   an error message will be displayed.
    # @raise [Errno::ENOENT] If an error occurs while creating or writing to the file,
    #   an error message will be displayed.
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
    
    # Exports data to a text file.
    #
    # This method takes an array of objects and exports them to a text file
    # specified by the `file_path`. It expects that each object's `attributes`
    # method returns an array of attribute values. Each attribute value is joined
    # using a tab character ('\t') as a delimiter to create tab-separated values
    # in the text file.
    #
    # @param objects [Array] The objects to export to a text file.
    # @param file_path [String] The path to the text file to be created.
    #
    # @example Export user data to a text file:
    #   objects = [user1, user2]
    #   DataExport::Exporter.export_to_text(objects, 'users.txt')
    #
    # @return [void]
    #
    # @note If the `objects` array is empty, this method will output a message and
    #   not create a file.
    # @raise [Errno::ENOENT] If an error occurs while creating or writing to the file,
    #   an error message will be displayed.
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
    
    # ...
    
    # Exports data to an XLS (Excel) file.
    #
    # This method takes an array of objects and exports them to an XLS file
    # specified by the `file_path`. It expects that each object's `attributes`
    # method returns a hash of attribute names and values. The method creates an
    # XLS workbook with a single worksheet and populates it with data from the
    # objects.
    #
    # @param objects [Array] The objects to export to an XLS file.
    # @param file_path [String] The path to the XLS file to be created.
    #
    # @example Export user data to an XLS file:
    #   objects = [user1, user2]
    #   DataExport::Exporter.export_to_xls(objects, 'users.xlsx')
    #
    # @return [void]
    #
    # @note If the `objects` array is empty, this method will create an empty XLS file.
    # @raise [StandardError] If an error occurs while writing to the XLS file,
    #   an error message will be displayed.
    def self.export_to_xls(objects, file_path)
      begin
        Axlsx::Package.new do |p|
          p.workbook.add_worksheet(name: 'Data') do |sheet|
            if objects.empty?
              puts 'No objects to export.' # Or handle this case as needed
            else
              # Write the header row using the attribute names from the first object
              sheet.add_row(objects.first.attributes.keys)
              
              # Write the object's attribute values as data rows
              objects.each do |obj|
                sheet.add_row(obj.attributes.values)
              end
            end
          end
          p.serialize(file_path)
        end
      rescue StandardError => e
        puts "An error occurred while exporting to XLS: #{e.message}"
      end
    end
    
  end
end