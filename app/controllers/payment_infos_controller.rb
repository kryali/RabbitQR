class PaymentInfosController < ApplicationController
  # GET /payment_infos
  # GET /payment_infos.xml
  def index
    redirect_to :root
=begin
    @payment_infos = PaymentInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payment_infos }
    end
=end
  end

  # GET /payment_infos/1
  # GET /payment_infos/1.xml
  def show
    @payment_info = PaymentInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment_info }
    end
  end

  # GET /payment_infos/new
  # GET /payment_infos/new.xml
  def new
    @payment_info = PaymentInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment_info }
    end
  end

  # GET /payment_infos/1/edit
  def edit
    @payment_info = PaymentInfo.find(params[:id])
  end

  # POST /payment_infos
  # POST /payment_infos.xml
  def create
    params[:payment_info].merge!({:user_id => session[:user_id]})
    @payment_info = PaymentInfo.new(params[:payment_info])

    respond_to do |format|
      if @payment_info.save
        format.html { redirect_to(@payment_info, :notice => 'Payment info was successfully created.') }
        format.xml  { render :xml => @payment_info, :status => :created, :location => @payment_info }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payment_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /payment_infos/1
  # PUT /payment_infos/1.xml
  def update
    @payment_info = PaymentInfo.find(params[:id])

    respond_to do |format|
      if @payment_info.update_attributes(params[:payment_info])
        format.html { redirect_to(@payment_info, :notice => 'Payment info was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payment_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_infos/1
  # DELETE /payment_infos/1.xml
  def destroy
    @payment_info = PaymentInfo.find(params[:id])
    @payment_info.destroy

    respond_to do |format|
      format.html { redirect_to(payment_infos_url) }
      format.xml  { head :ok }
    end
  end
end
