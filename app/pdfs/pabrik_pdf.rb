class PabrikPdf < Prawn::Document
	def initialize(pabrik)
		super(top_margin: 70)
		@pabrik = pabrik
		nama_pabrik
		daftar_kreditur
	end
	
	def nama_pabrik
		text "Pabrik #{@pabrik.pabrik_name}", size: 20, style: :bold
	end

	def daftar_kreditur
		move_down 10
		table krediturs do
			row(0).font_style = :bold
			columns(1..2).align = :center
			self.row_colors = ["DDDDDD", "FFFFFF"]
			self.header = true
		end
	end

	def krediturs
		[["Nama Kreditur", "Alamat", "Telepon"]]+
		@pabrik.kreditur_pabriks.map do |kreditur|
			[Kreditur.find(kreditur.kreditur_id).kreditur_name,
			 Kreditur.find(kreditur.kreditur_id).kreditur_address,
			 Kreditur.find(kreditur.kreditur_id).kreditur_phone]
		end
	end
end