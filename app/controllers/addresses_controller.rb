class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    address_count = Address.count
    @page_number = params[:page].to_i.positive? ? params[:page].to_i : 1
    offset = Address::PER_PAGE * (@page_number - 1)
    @number_of_pages = (address_count.to_f / Address::PER_PAGE).ceil
    @addresses = Address.order(id: :asc).limit(Address::PER_PAGE).offset(offset)
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show; end

  # GET /addresses/new
  def new
    @address = Address.new
    @user = @address.build_user
  end

  # GET /addresses/1/edit
  def edit
    @user = @address.user
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to @address, notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = Address.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:city, :zip, :street, :user_id,
                                    user_attributes: [:id, :first_name, :last_name, :email, :type])
  end
end
