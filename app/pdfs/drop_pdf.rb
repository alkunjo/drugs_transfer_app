class	DropPdf < Prawn::Document
	include ActiveSupport::NumberHelper
	def initialize(transaksi)
		super(top_margin: 30)
		@transaksi = transaksi
		header_page
		print_table
		footer_page
	end

	def header_page
		sender = Outlet.find(@transaksi.sender_id)
		receiver = Outlet.find(@transaksi.receiver_id)	
		sid = @transaksi.sender_id.to_s
    if sid.length == 1
      sid = '0'+sid
    end

    rid = @transaksi.receiver_id.to_s
    if rid.length == 1
      rid = '0'+rid
    end	
    font_size(10) {text "PT. Kimia Farma Apotek"}
		move_down 3
		font_size(10) {text "Apotek #{receiver.outlet_name}"}
		move_down 3
		font_size(10) {text "#{receiver.outlet_city}"}
		move_down 15
		font_size(13) {text "FORM DROPPING BARANG APOTEK", align: :center, style: :bold}
		move_down 3
		font_size(12) {text "Dropping Ke: Apotek #{sender.outlet_name}", align: :center}
		move_down 3
		font_size(12) {text "Tahun Dropping: #{@transaksi.dropped_at.strftime("%Y")}    Tahun BPBA: #{@transaksi.asked_at.strftime("%Y")} ", align: :center}
		move_down 3
		font_size(12) {text "Nomor Dropping: D#{rid}#{sid}#{@transaksi.dropped_at.strftime("%d%m%Y")} Nomor BPBA: B#{sid}#{rid}#{@transaksi.created_at.strftime("%d%m%Y")}", align: :center}
		move_down 3
		font_size(12) {text "Tanggal   : #{@transaksi.dropped_at.strftime("%d/%m/%Y")}", align: :center}
		move_down 10
	end

	def print_table
		table table_drop do
			row(0).font_style = :bold
			columns(0..1).align = :center
			self.row_colors = ["CDFFFF", "FFFFFF"]
			self.header = true
			self.position = :center
		end
		move_down 30
	end

	def table_drop
		numb = 0
		total = 0
		[["No.","Nama Obat", "Qty Dropping", "Hrg Satuan", "Total Harga"]]+
		@transaksi.dtrans.map do |dtran|
			numb = numb + 1
			total = total + dtran.dtd_qty*Obat.find(dtran.obat_id).obat_hpp
			[numb, 
			 Obat.find(dtran.obat_id).obat_name, 
			 "#{dtran.dtd_qty} #{Kemasan.find(Obat.find(dtran.obat_id).kemasan_id).kemasan_unit} @#{Kemasan.find(Obat.find(dtran.obat_id).kemasan_id).kemasan_cap.to_s}",
			 to_rupiah(Obat.find(dtran.obat_id).obat_hpp),
			 to_rupiah(dtran.dtd_qty*Obat.find(dtran.obat_id).obat_hpp)]
		end+
		[[{:content => "Total", :colspan => 4},to_rupiah(total)]]

	end

	def footer_page
		ttd = [["PJ Gudang APP Pemberi", "Penerima Barang", "PJ Penerima"],["","",""]]
		table ttd do
			row(0).font_style = :bold
			row(1).height = 60
			self.header = true
			self.position = :center
		end
	end

	private
	def to_rupiah(fill)
		number_to_currency( fill, unit: "Rp. ", separator: ',', delimeter: '.' )
	end
end