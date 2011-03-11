class TransactionsController < ApplicationController
  skip_before_filter :authenticate, :only => [:phonePay]

  def phonePay
    #logger.debug params
    @payer = User.find(:first, :conditions => {:phone => params[:payerPhone]})
    @receiver = User.find(:first, :conditions => {:phone => params[:receiverPhone]})
    unless @payer
      @payer = User.create({:username => params[:payerPhone] , :password => '', :phone => params[:payerPhone]})
    end
    unless @receiver
      @receiver = User.create({:username => params[:receiverPhone], :password => '', :phone => params[:receiverPhone]})
    end
    #logger.debug "PAYER NULL" unless @payer
    #logger.debug "RECEIVER NULL" unless @receiver
    amount = params[:amount].to_f
    t = Transaction.create({ :receiver_id => @receiver.id, :payer_id => @payer.id, :amount =>  amount})
    #logger.debug "Creating transaction between Reciever: #{@receiver.phone} Payer: #{@payer.phone}"
    msg = "<RabbitQR> You have received a payment of $#{amount} from #{@payer.username}."
    send_text(@receiver.phone, msg)
    render :json =>  t
  end


  # GET /transactions
  # GET /transactions.xml
  def index
    redirect_to :root
    return
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.xml
  def show
    @user = User.find(session[:user_id])
    @transaction = Transaction.find(params[:id])
    if (@transaction.payer_id != session[:user_id] && @transaction.receiver_id != session[:user_id] )
      redirect_to :root
      return
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.xml
  def new
    @user = User.find(session[:user_id])
    @transaction = Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @user = User.find(session[:user_id])
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.xml
  def create
    @user = User.find(session[:user_id])
    @transaction = Transaction.new(params[:transaction].merge({:payer_id => session[:user_id]}))

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully created.') }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.xml
  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.xml
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end
end
