class SafetyStock < ApplicationRecord
	self.primary_key = [:ss_period_id, :stock_id]
	belongs_to :ss_period
	belongs_to :stock

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |safety_stock|
				csv << safety_stock.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file)
		accessible_attributes = [:safety_stock_qty]
	  spreadsheet = open_spreadsheet(file)
	  
	  # ignore header
	  header = spreadsheet.row(1)

	  # hitung per baris
	  (2..spreadsheet.last_row).each do |i|

		  # 0. initiate variabel
		  #		 - periode
		  # 	 - kebutuhan total  (kebutal)
		  # 	 - rata-rata kebutuhan (rabut)
		  # 	 - (kebutuhan - rata-rata)^2 (keburat)
		  # 	 - standar deviasi (stardev)
		  # 	 - safety stock (safety_stock)
		  # 	 - safety factor (saftor)

		  periode = 0
		  kebutal = 0
		  rabut = 0.0
		  keburat = 0.0
		  stardev = 0.0
		  safety_stock = 0.0
		  saftor = 1.65

		  # 1. calculate kebutal
		  (2..spreadsheet.last_column).each do |c|
		  	periode = periode + 1
		  	kebutal = kebutal + spreadsheet.cell(i,c)
		  end
		  logger.debug "Periode: #{periode}"
		  logger.debug "Kebutal: #{kebutal}"

		  # 2. calculate rabut
		  rabut = kebutal / periode
		  logger.debug "Rabut: #{rabut}"

		  # 3. kurangi tiap kebutuhan dengan rabut sekaligus hitung keburat dan ditotal
		  (2..spreadsheet.last_column).each do |c|
		  	keburat = keburat + ((spreadsheet.cell(i,c)-rabut)**2)
		  end
		  logger.debug "Keburat: #{keburat}"

		  # 4. calculate stardev
		  periode = periode - 1
		  stardev = (keburat/periode)**(0.5)
		  logger.debug "Stardev: #{stardev}"

		  # 5. calculate safety_stock
		  safety_stock = saftor * stardev
		  safety_stock = safety_stock.round
		  logger.debug "Safety Stock: #{safety_stock}"

		  
	  
	  end

	  # header = spreadsheet.row(1)
	  # (2..spreadsheet.last_row).each do |i|
	  #   row = Hash[[header, spreadsheet.row(i)].transpose]
	  #   safety_stock = find_by_safety_stock_name(row["safety_stock_name"])
	  #   if safety_stock.blank?
	  #   	safety_stock = SafetyStock.create(safety_stock_name: row["safety_stock_name"], safety_stock_judul: row["safety_stock_judul"])
	  #   end
	  #   safety_stock.save!
	  # end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::CSV.new(file.path, packed: false, file_warning: :ignore)
	  when ".xls" then Roo::Excel.new(file.path, packed: false, file_warning: :ignore)
	  when ".xlsx" then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore)
	  else raise "Tipe file tidak dikenal: #{file.original_filename}"
	  end
	end
end
