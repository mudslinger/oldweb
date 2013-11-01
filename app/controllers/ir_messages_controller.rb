class IrMessagesController < ApplicationController
  before_action :set_ir_message, only: [:show, :edit, :update, :destroy]

  # GET /ir_messages
  # GET /ir_messages.json
  def index
    @ir_messages = IrMessage.all
  end

  # GET /ir_messages/1
  # GET /ir_messages/1.json
  def show
  end

  # GET /ir_messages/new
  def new
    @ir_message = IrMessage.new
  end

  # GET /ir_messages/1/edit
  def edit
  end

  # POST /ir_messages
  # POST /ir_messages.json
  def create
    @ir_message = IrMessage.new(ir_message_params)

    respond_to do |format|
      if @ir_message.save
        format.html { redirect_to @ir_message, notice: 'Ir message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ir_message }
      else
        format.html { render action: 'new' }
        format.json { render json: @ir_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ir_messages/1
  # PATCH/PUT /ir_messages/1.json
  def update
    respond_to do |format|
      if @ir_message.update(ir_message_params)
        format.html { redirect_to @ir_message, notice: 'Ir message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ir_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ir_messages/1
  # DELETE /ir_messages/1.json
  def destroy
    @ir_message.destroy
    respond_to do |format|
      format.html { redirect_to ir_messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ir_message
      @ir_message = IrMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ir_message_params
      params[:ir_message]
    end
end
