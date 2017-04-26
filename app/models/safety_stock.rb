class SafetyStock < ApplicationRecord
	self.primary_key = :ss_period_id, :stock_id
	belongs_to :ss_period, class_name: "SsPeriod"
	belongs_to :stock, class_name: "Stock"
	has_one :obat, through: :stock
	attr_accessor :ss_period_id, :stock_id

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |safety_stock|
				csv << safety_stock.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file, week_periode)
	  spreadsheet = open_spreadsheet(file)
	  
	  # ignore header
	  header = spreadsheet.row(1)

	  # cara 1
	  # hitung per baris
	  # (2..spreadsheet.last_row).each do |i|

		 #  # 0. initiate variabel
		 #  #		 - periode
		 #  # 	 - kebutuhan total  (kebutal)
		 #  # 	 - rata-rata kebutuhan (rabut)
		 #  # 	 - (kebutuhan - rata-rata)^2 (keburat)
		 #  # 	 - standar deviasi (stardev)
		 #  # 	 - safety stock (safety_stock)
		 #  # 	 - safety factor (saftor)

		 #  periode = 0
		 #  kebutal = 0
		 #  rabut = 0.0
		 #  keburat = 0.0
		 #  stardev = 0.0
		 #  safety_stock = 0.0
		 #  saftor = 1.65

		 #  # 1. calculate kebutal
		 #  (2..spreadsheet.last_column).each do |c|
		 #  	periode = periode + 1
		 #  	kebutal = kebutal + spreadsheet.cell(i,c)
		 #  end
		 #  # logger.debug "Periode: #{periode}"
		 #  # logger.debug "Kebutal: #{kebutal}"

		 #  # 2. calculate rabut
		 #  rabut = kebutal / periode
		 #  # logger.debug "Rabut: #{rabut}"

		 #  # 3. kurangi tiap kebutuhan dengan rabut sekaligus hitung keburat dan ditotal
		 #  (2..spreadsheet.last_column).each do |c|
		 #  	keburat = keburat + ((spreadsheet.cell(i,c)-rabut)**2)
		 #  end
		 #  # logger.debug "Keburat: #{keburat}"

		 #  # 4. calculate stardev
		 #  periode = periode - 1
		 #  stardev = (keburat/periode)**(0.5)
		 #  # logger.debug "Stardev: #{stardev}"

		 #  # 5. calculate safety_stock
		 #  safety_stock = saftor * stardev
		 #  safety_stock = safety_stock.round
		 #  # logger.debug "Safety Stock: #{safety_stock}"

		 #  # 6. take stock_id
		 #  stock_id = spreadsheet.cell(i,1)
		 #  # logger.debug "Stock ID: #{stock_id.to_i}"

		 #  # 7. take ss_period_id
		 #  # logger.debug "ss_period_id: #{week_periode}"

		 #  # 8. save to safetystock
		 #  sql = "INSERT INTO safety_stocks(`ss_period_id`, `stock_id`, `safety_stock_qty`, `created_at`, `updated_at`) VALUES('#{week_periode}','#{stock_id.to_i}','#{safety_stock}', '#{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}', '#{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}')"
		 #  ActiveRecord::Base.connection.execute(sql)

		 #  # 9. update current_ss on stock_tables
		 #  stock = Stock.find_by(stock_id: stock_id)
		 #  stock.update_attribute(:current_ss, safety_stock)
		 #  stock.save!
	  
	  # end

	  # cara 2
	  sqlinsert = "INSERT INTO safety_stocks(`ss_period_id`,`stock_id`,`safety_stock_qty`,`created_at`,`updated_at`) VALUES "
	  sqlupdate = "UPDATE stocks SET current_ss = (case "
	  (2..spreadsheet.last_row).each do |i|
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

		  # 2. calculate rabut
		  rabut = kebutal / periode

		  # 3. kurangi tiap kebutuhan dengan rabut sekaligus hitung keburat dan ditotal
		  (2..spreadsheet.last_column).each do |c|
		  	keburat = keburat + ((spreadsheet.cell(i,c)-rabut)**2)
		  end

		  # 4. calculate stardev
		  periode = periode - 1
		  stardev = (keburat/periode)**(0.5)

		  # 5. calculate safety_stock
		  safety_stock = saftor * stardev
		  safety_stock = safety_stock.round

		  # 6. take stock_id
		  stock_id = spreadsheet.cell(i,1)

	  	sqlinsert = sqlinsert + "('#{week_periode}','#{stock_id.to_i}','#{safety_stock}', '#{DateTime.now.strftime('%Y-%m-%d %H:%M:%S')}', '#{DateTime.now.strftime('%Y-%m-%d %H:%M:%S')}'), "
			sqlupdate = sqlupdate + "WHEN stock_id = #{stock_id.to_i} THEN #{safety_stock} "	  	
	  	if (i-1)%100 == 0
	  		sqlinsert = sqlinsert[0..-3]
	  		# mass insert query
		 		ActiveRecord::Base.connection.execute(sqlinsert)

	  		# reset insert query
	  		sqlinsert = "INSERT INTO safety_stocks(`ss_period_id`,`stock_id`,`safety_stock_qty`,`created_at`,`updated_at`) VALUES "
	  	end
	  end																																																																										
		
		# final insert query
		sqlinsert = sqlinsert[0..-3]
 		ActiveRecord::Base.connection.execute(sqlinsert)
 		
 		# final update query
 		sqlupdate = sqlupdate + "end)"
 		ActiveRecord::Base.connection.execute(sqlupdate)
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
