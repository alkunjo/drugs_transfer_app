class	LapaskPdf < Prawn::Document
	include ActiveSupport::NumberHelper
	include TransaksisHelper
	def initialize(cek, sender, month, year)
		super(top_margin: 30)
		@cek = cek
		@sender = sender
		@month = month
		@year = year

		header_page
		print_table
		footer_page
	end

	def header_page
		font_size(10) {text "PT. Kimia Farma Apotek"}
		move_down 3
		font_size(10) {text "Apotek #{@sender.outlet_name}"}
		move_down 3
		font_size(10) {text "#{@sender.outlet_address}"}
		move_down 3
		font_size(10) {text "#{@sender.outlet_city}"}
		move_down 15
		font_size(12) {text "Laporan Permintaan Obat", style: :bold, align: :center}
		move_down 3
		font_size(12) {text "Bulan #{bulan(@month)} Tahun #{@year}", style: :bold, align: :center}
		move_down 3
	end

	def print_table
		table table_ask do
			row(0).font_style = :bold
			row(0).columns(0..4).align = :center
			self.row_colors = ["CDFFFF", "FFFFFF"]
			self.header = true
			self.position = :center
			row(0).column(4).width = 120
			row(-1).align = :center
		end
		move_down 30
	end

	def table_ask
		numb = 0
		grand_total = 0
		[["No.","Nomor BPBA", "Apotek yang Dituju", "Jumlah Minta", "Keterangan"]]+
		@cek.map do |transaksi|
			numb = numb + 1

			sid = transaksi.sender_id.to_s
	    if sid.length == 1
	      sid = '0'+sid
	    end

	    rid = transaksi.receiver_id.to_s
	    if rid.length == 1
	      rid = '0'+rid
	    end

	    total = 0
	    transaksi.dtrans.map do |dtran|
	    	total = total + (dtran.dta_qty*Obat.find(dtran.obat_id).obat_hpp)
	    end

	    grand_total = grand_total + total

			[numb, 
			 "B#{sid}#{rid}#{transaksi.created_at.strftime("%d%m%Y")}", 
			 Outlet.find(transaksi.receiver_id).outlet_name,
			 to_rupiah(total),
			 ""]
		end+
		[[{:content => "Total", :colspan => 3},{:content => "#{to_rupiah(grand_total)}", :colspan => 2}]]
	end

	def footer_page
		
	end

	private
	def to_rupiah(fill)
		number_to_currency( fill, unit: "Rp. ", separator: ',', delimeter: '.' )
	end
end