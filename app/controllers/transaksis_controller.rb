class TransaksisController < ApplicationController
  include TransaksisHelper
  before_action :authenticate_user!
  before_action :set_activities
  before_action :set_transaksi, only: [:edit, :update, :destroy, :del, :show_ask, :show_drop, :show_accept, :skrip_bpba, :skrip_drop, :validate_ask, :validate_drop]
  before_action :set_transaksi_ask, only: [:index, :show_a]
  before_action :set_transaksi_drop, only: [:index, :show_d]
  before_action :set_transaksis, only: [:ask, :drop, :accept, :new, :create]
  autocomplete :outlet, :outlet_name, full: true

  def index
  	path = case current_user.role
  		when 'Pengadaan'
  			ask_transaksis_path
  		when 'Gudang', 'Admin Gudang'
  			drop_transaksis_path
  		when 'Manager', 'Admin'
  			report_ask_transaksis_path
  		else
  			ask_transaksis_path
  	end

  	redirect_to path
  end

  # ini buat index permintaan, dropping dan penerimaan obat
  def ask
    @transaksi = Transaksi.find_by(sender_id: current_user.outlet_id, trans_status: nil)
    respond_to do |format|
      format.html {render "ask"}
    end
  end

  def drop  	
  end

  def accept
  	if params[:id].present?
  		@transaksi = Transaksi.find(params[:id])
  	end
  end
  # ini buat index permintaan, dropping dan penerimaan obat


  # ini digunakan untuk nampilin modal detail transaksi per fungsi permintaan, dropping dan penerimaan obat
  def show_ask
    respond_to do |format|
      format.js {render "show_ask"}
    end
  end

  def show_drop
    respond_to do |format|
      format.js {render "show_drop"}
    end
  end  

  def show_accept
    respond_to do |format|
      format.js {render "show_accept"}
    end
  end
  # ini digunakan untuk nampilin modal detail transaksi per fungsi permintaan, dropping dan penerimaan obat


  # ini digunakan untuk build report view
  def report_ask
    if current_user.admin?
      @bulan = Transaksi.select("distinct CONCAT_WS(' ', MONTHNAME(asked_at), YEAR(asked_at)) as bulan")
    elsif current_user.pengadaan?
      @bulan = Transaksi.select("distinct CONCAT_WS(' ', MONTHNAME(asked_at), YEAR(asked_at)) as bulan").where("sender_id = '#{current_user.outlet_id}' ")
    end
    respond_to do |format|
      format.html {render "report_ask"}
    end
  end

  def report_drop
    if current_user.admin?
      @bulan = Transaksi.select("distinct CONCAT_WS(' ', MONTHNAME(dropped_at), YEAR(dropped_at)) as bulan")
    elsif current_user.gudang?
      @bulan = Transaksi.select("distinct CONCAT_WS(' ', MONTHNAME(dropped_at), YEAR(dropped_at)) as bulan").where("receiver_id = '#{current_user.outlet_id}' ")
    end
    respond_to do |format|
      format.html {render "report_drop"}
    end
  end

  def report_accept
    if current_user.admin?
      @bulan = Transaksi.select("distinct CONCAT_WS(' ', MONTHNAME(accepted_at), YEAR(accepted_at)) as bulan")
    elsif current_user.gudang?
      @bulan = Transaksi.select("distinct CONCAT_WS(' ', MONTHNAME(accepted_at), YEAR(accepted_at)) as bulan").where("sender_id = '#{current_user.outlet_id}' ")
    end
    respond_to do |format|
      format.html {render "report_accept"}
    end
  end

  def report_ask_control
    
    # get value from input parameter
    apotek = params[:outlet_name].nil? ? Outlet.find(current_user.outlet_id).outlet_name : params[:outlet_name][0] 
    @sender = Outlet.where(outlet_name: apotek).first
    panjang = params[:bulan].length - 6
    @month = params[:bulan][0..panjang]
    @year = params[:bulan].split(//).last(4).join
    # render :js => "alert('#{apotek}');"

    @cek = Transaksi
    .where("sender_id = '#{@sender.outlet_id}'")
    .where("MONTHNAME(asked_at) = '#{@month}'")
    .where("YEAR(asked_at) = '#{@year}'")
    .where(trans_status: [1,2,3])
    
    # cek transaksi
    if @cek.exists?
      # render :js => "alert('#{@cek.count}');"
      respond_to do |format|
        format.js {render "report_ask", locals: {sender: @sender, month: @month, year: @year}}
        format.pdf do 
          pdf = LapaskPdf.new(@cek, @sender, @month, @year)
          # pdf = Prawn::Document.new
          send_data pdf.render, filename: "Laporan Permintaan Obat #{@sender} #{@month} #{@year}.pdf", type: "application/pdf", disposition: "inline"
        end
      end
    else
      render :js => "alert('Transaksi tidak ditemukan');"
    end
  end

  def report_drop_control
    # get value from input parameter
    apotek = params[:outlet_name].nil? ? Outlet.find(current_user.outlet_id).outlet_name : params[:outlet_name][0] 
    @receiver = Outlet.where(outlet_name: apotek).first
    panjang = params[:bulan].length - 6
    @month = params[:bulan][0..panjang]
    @year = params[:bulan].split(//).last(4).join
    # render :js => "alert('#{apotek}');"

    @cek = Transaksi
    .where("receiver_id = '#{@receiver.outlet_id}'")
    .where("MONTHNAME(dropped_at) = '#{@month}'")
    .where("YEAR(dropped_at) = '#{@year}'")
    .where(trans_status: [2,3])
    
    # cek transaksi
    if @cek.exists?
      # render :js => "alert('#{@cek.count}');"
      respond_to do |format|
        format.js {render "report_drop", locals: {receiver: @receiver, month: @month, year: @year}}
        format.pdf do 
          pdf = LapdropPdf.new(@cek, @receiver, @month, @year)
          # pdf = Prawn::Document.new
          send_data pdf.render, filename: "Laporan Dropping Obat #{@receiver.outlet_name} #{@month} #{@year}.pdf", type: "application/pdf", disposition: "inline"
        end
      end
    else
      render :js => "alert('Transaksi tidak ditemukan');"
    end
  end

  def report_accept_control
    # get value from input parameter
    apotek = params[:outlet_name].nil? ? Outlet.find(current_user.outlet_id).outlet_name : params[:outlet_name][0] 
    @sender = Outlet.where(outlet_name: apotek).first
    panjang = params[:bulan].length - 6
    @month = params[:bulan][0..panjang]
    @year = params[:bulan].split(//).last(4).join
    # render :js => "alert('#{apotek}');"

    @cek = Transaksi
    .where("sender_id = '#{@sender.outlet_id}'")
    .where("MONTHNAME(accepted_at) = '#{@month}'")
    .where("YEAR(accepted_at) = '#{@year}'")
    .where(trans_status: [2,3])
    
    # cek transaksi
    if @cek.exists?
      # render :js => "alert('#{@cek.count}');"
      respond_to do |format|
        format.js {render "report_accept", locals: {sender: @sender, month: @month, year: @year}}
        format.pdf do 
          pdf = LaptrimPdf.new(@cek, @sender, @month, @year)
          # pdf = Prawn::Document.new
          send_data pdf.render, filename: "Laporan Dropping Obat #{@sender.outlet_name} #{@month} #{@year}.pdf", type: "application/pdf", disposition: "inline"
        end
      end
    else
      render :js => "alert('Transaksi tidak ditemukan');"
    end
  end
  # ini digunakan untuk build report view

  # ini digunakan untuk nyetak skrip per fungsi 
  def skrip_bpba
  	@transaksi = Transaksi.find(params[:id])
    sender = @transaksi.sender_id.to_s
    if sender.length == 1
      sender = '0'+sender
    end

    receiver = @transaksi.receiver_id.to_s
    if receiver.length == 1
      receiver = '0'+receiver
    end
    respond_to do |format|
      format.pdf do 
        pdf = BpbaPdf.new(@transaksi)
        # pdf = Prawn::Document.new
        send_data pdf.render, filename: "B#{sender}#{receiver}#{@transaksi.asked_at.strftime("%d%m%Y")}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def skrip_drop
    @transaksi = Transaksi.find(params[:id])
    sender = @transaksi.sender_id.to_s
    if sender.length == 1
      sender = '0'+sender
    end

    receiver = @transaksi.receiver_id.to_s
    if receiver.length == 1
      receiver = '0'+receiver
    end
    respond_to do |format|
      format.pdf do
        pdf = DropPdf.new(@transaksi)
        send_data pdf.render, filename: "D#{sender}#{receiver}#{@transaksi.dropped_at.strftime("%d%m%Y")}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def skrip_accept
  	@transaksi = Transaksi.find(params[:id])
    sender = @transaksi.sender_id.to_s
    if sender.length == 1
      sender = '0'+sender
    end

    receiver = @transaksi.receiver_id.to_s
    if receiver.length == 1
      receiver = '0'+receiver
    end
    respond_to do |format|
      format.pdf do
        pdf = AcceptPdf.new(@transaksi)
        send_data pdf.render, filename: "T#{sender}#{receiver}#{@transaksi.accepted_at.strftime("%d%m%Y")}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end
  # ini digunakan untuk nyetak skrip per fungsi 


  # ini digunakan untuk memvalidasi fungsi (update status transaksi aja sebenernya)
  def validate_ask
    if @transaksi.dtrans.exists?
      penerima = Outlet.find_by(outlet_id: params[:receiver_id])
      @transaksi.update_attributes(:trans_status => 1, :asked_at => Time.now.strftime("%Y-%m-%d %H:%M:%S"), :receiver_id => penerima.outlet_id)
      @transaksi.create_activity action: 'validate_ask', owner: current_user, recipient: penerima
      respond_to do |format|
        return new
      end
    end
  end

  def validate_drop
    @transaksi.update_attributes(:trans_status => 2, :dropped_at => Time.now.strftime("%Y-%m-%d %H:%M:%S"))
    if @transaksi
      penerima = Outlet.find(@transaksi.sender_id)
      @transaksi.create_activity action: 'validate_drop', owner: current_user, recipient: penerima
      @dtrans = @transaksi.dtrans
      @dtrans.each do |dtran|
        # update stok
        stok = Stock.where(outlet_id: current_user.outlet_id).where(obat_id: dtran.stock.obat_id).first
        minta = dtran.dtd_qty.nil? ? 0 : dtran.dtd_qty
        hasil = stok.stok_qty - minta
        stok.update_attribute(:stok_qty, hasil)
        if dtran.dtd_qty.nil? 
          dtran.update_attribute(:dtd_qty, 0)
        end
      end
      respond_to do |format|
        flash.now[:success] = "Validasi Dropping berhasil dilakukan"
        format.js {render "show_drop"}
      end
    else
      respond_to do |format|
        flash.now[:danger] = "Maaf ada kesalahan query. Coba lagi"
        format.js {render "warn"}
      end
    end
  end

  def validate_accept
    @tran = Transaksi.find(params[:id])
    @tran.update_attributes(:trans_status => 3, :accepted_at => Time.now.strftime("%Y-%m-%d %H:%M:%S"))
    if @tran
      penerima = Outlet.find(@tran.receiver_id)
      @tran.create_activity action: 'validate_accept', owner: current_user, recipient: penerima
      @dtrans = @tran.dtrans
      @dtrans.each do |dtran|
        @stok = Stock.where(outlet_id: @tran.sender_id, obat_id: dtran.stock.obat_id).first
        trima = dtran.dtt_qty.present? ? dtran.dtt_qty : 0        
        stok = @stok.stok_qty + trima
        @stok.update_attributes(:stok_qty => stok, :updated_at => Time.now.strftime("%Y-%m-%d %H:%M:%S"))
      end
    end
    flash[:success] = "Stok berhasil ditambahkan"
    redirect_to stocks_url
  end
  # ini digunakan untuk memvalidasi fungsi (update status transaksi aja sebenernya)


  # ini dibuat untuk dapetin transaksi dari simple form
  def get_accept
    
    # substring nomor BPBA
    @sid = params[:obat_in][1..2]
    @rid = params[:obat_in][3..4]
    @tgl_day = params[:obat_in][5..6]
    @tgl_bln = params[:obat_in][7..8]
    @tgl_yrs = params[:obat_in][9..12]

    # respond_to do |format|
    #   format.js {render 'alert'}
    # end
    @tran = Transaksi.where(sender_id: @sid, receiver_id: @rid).first
    @dtrans = @tran.dtrans

    @dtrans.each do |dtran|
      if dtran.dtt_qty.nil?
        if dtran.dtd_qty.nil?
          dtran.update_attribute(:dtd_qty, 0) 
          dtran.update_attribute(:dtt_qty, 0) 
        else
          dtran.update_attribute(:dtt_qty, dtran.dtd_qty)
        end
      end
    end

    respond_to do |format|
      format.js {render 'trans'}
    end
  end
  # ini dibuat untuk dapetin transaksi dari simple form


  # ini digunakan untuk konfirmasi validasi dropping aja
  def valdrop
    cek = Dtran.where(dtd_qty: nil).where(transaksi_id: params[:id]).count
    total = Dtran.where(transaksi_id: params[:id]).count
    @transaksi = Transaksi.find(params[:id])
    if cek == 0
      flash.now[:danger] = "#{total} permintaan telah terisi. "
    else
      flash.now[:danger] = "#{cek} permintaan belum terisi dari #{total} permintaan. "
    end
    
    respond_to do |format|
      format.js {render 'valdrop'}
    end
  end
  # ini digunakan untuk konfirmasi validasi dropping aja


  def new
    set_transaksis
    @transaksi = Transaksi.new
    respond_to do |format|
      format.js {render "new"}
    end
  end

  # tambah permintaan obat
  def add_ask
    @transaksi = Transaksi.find_or_create_by(sender_id: current_user.outlet_id, trans_status: nil)
    @dtrans = @transaksi.dtrans
    @dtran = Dtran.new(transaksi_id: @transaksi.transaksi_id)
    # DtransController.new
    respond_to do |format|
      format.js {render "add_ask"}
    end
  end

  # cek ketersediaan obat
  def cek_availability
    @transaksi = Transaksi.find(params[:transaksi_id])

    # 1. find 5 nearby location
    locations = Distance.where(origin_id: current_user.outlet_id).where.not(destination_id: current_user.outlet_id).order(distance: :asc).limit(5)
    cek_stok = 0
    destination = -1

    # 2. find stock availability in 5 nearby location
    locations.each do |lokasi|
      # logger.debug "#{lokasi.destination.outlet_name}: #{lokasi.distance}"
      @transaksi.dtrans.each do |dtran|
        
        obat = Obat.find_by(obat_name: dtran.stock.obat.obat_name) # 3. find the drugs
        stok = Stock.find_by(obat_id: obat.obat_id, outlet_id: lokasi.destination_id) # 4. take stok

        # 5. check if the stock is more or same with current_ss when it's reduced by dta_qty so the stock is unavailable and stop the stock loop
        if (stok.stok_qty - dtran.dta_qty) < stok.current_ss
          cek_stok = -1
          break
        else # else stok is available
          cek_stok = 1
        end
      end

      if cek_stok == 1 # if stock is available assign the destination_id and stop the destination loop
        destination = lokasi.destination_id
        break
      end
    end
    # flash.now[:success] = "Dropping obat berhasil ditambahkan"
    if cek_stok == 1
      flash.now[:success] = "Outlet #{Outlet.find_by(outlet_id: destination).outlet_name} memungkinkan untuk diminta. #{view_context.link_to('Validasi Permintaan', validate_ask_transaksi_path(id: @transaksi.transaksi_id, receiver_id: destination), remote: true, class: 'btn btn-md btn-primary') }".html_safe
    else
      flash.now[:danger] = "Mohon maaf, tidak ditemukan obat yang dicari."
    end    

    respond_to do |format|
      format.js {render 'avail'}
    end

  end

  def edit
  end

  def create
    @transaksi = Transaksi.new(transaksi_params)
    cek = Transaksi.where(receiver_id: @transaksi.receiver_id).where(trans_status: 2)
    if cek #sudah tervalidasi dropping      
      receiver = Outlet.find_by(outlet_name: @transaksi.outlet_name)
      if receiver.nil?
        flash.now[:notice] = 'Nama outlet harus diisi.'
        #flash.keep(:notice)
        respond_to do |format|
          format.js { render 'ask' }
        end 
        
      elsif current_user.pengadaan?
        @transaksi = Transaksi.create(sender_id: current_user.outlet_id, receiver_id: receiver.outlet_id)
        @transaksi.create_activity action: 'create', owner: current_user, recipient: receiver
        respond_to do |format|
          if @transaksi
            return new
          end
        end
      else
        flash.now[:notice] = 'Maaf Gudang tidak bisa membuat permintaan.'
        #flash.keep(:notice)
        respond_to do |format|
          format.js { render 'ask' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @transaksis, notice: 'Transaksi sebelumnya belum dikonfirmasi dropping.' }
      end
    end
  end

  def update
  end

  def del
  end

  def destroy
    @transaksi.destroy
    respond_to do |format|
      return new
    end
  end

  def get_autocomplete_items(parameters)
    items = active_record_get_autocomplete_items(parameters)
    items = items.where.not(outlet_id: current_user.outlet_id)
  end

  private
    def set_transaksi
      @transaksi = Transaksi.find(params[:id])
    end

    def set_outlet
      @outlet = Outlet.where(outlet_id: current_user.outlet_id).first
    end

    def set_transaksi_asks(cek)
      @transaksi_asks = cek
    end

    def get_transaksi_asks
      return @transaksi_asks
    end

    def set_transaksis
      if current_user.admin?
        @transaksis = Transaksi.all
      elsif current_user.pengadaan?
        @transaksis = Transaksi.where(sender_id: current_user.outlet_id).where.not(receiver_id: nil)
      elsif current_user.gudang?
        @transaksis = Transaksi.where(receiver_id: current_user.outlet_id).where(trans_status: [1,2,3])
      end          
    end

    def transaksi_params
      params.require(:transaksi).permit(:trans_status, :sender_id, :receiver_id, :sender_name, :receiver_name, :outlet_name)
    end

    def set_activities
      if current_user.admin?
        @activities = PublicActivity::Activity.all
      elsif current_user.pengadaan?
        @activities = PublicActivity::Activity.where(owner: current_user.user_id)
      elsif current_user.gudang? || current_user.admin_gudang? || current_user.manager?
        @activities = PublicActivity::Activity.where(recipient_id: current_user.outlet_id)
      end
    end
    
end