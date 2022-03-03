class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    companies = Company.where(id: params[:company_ids])
    if params[:name]
      companies.update_all(name: params[:name])
    end

    @companies = Company.all

    # this is just a hack so i don't get such url after submission
    # (/companies?company_ids%5B%5D=3&company_ids%5B%5D=2&name=new+company+name&commit=Update+company+names)
    # it basically gives me a fresh /companies page without the inputted form values sticking around
    redirect_to "/companies" unless request.fullpath == "/companies"
  end

  # GET /companies/1
  # GET /companies/1.json
  def show; end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit; end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def bulk_create_form; end

  def bulk_create
    # example: Company.create([{name: 'company1'}, {name: 'company2'}, {name: 'company3'}])
    # note that this will make separate INSERT statements for each company that will be created
    # params.require(:companies_to_create).map {|param| param.permit! }
    # Company.create!(params[:companies_to_create])

    # NOTE: this method is only available in Rails 6.
    # It will do a single "bulk" INSERT statement to create all the companies
    # If we need to ensure all rows are inserted we can use insert_all! the bang version directly.
    company_ids = Company.insert_all!(params[:companies_to_create])
    # this returns an #<ActiveRecord::Result, you can convert it to an array which will give you an array of
    # id_value hashes created (in PostgreSQL but not in MySQL): [{"id"=>14}, {"id"=>15}]

    # @companies = Company.where(id: company_ids.pluck('id'))

    # Example (another table/model) using pure SQL
    # insert into `shippers`(`ShipperID`,`CompanyName`,`Phone`) values
    # (1,'Speedy Express','(503) 555-9831'),
    # (2,'United Package','(503) 555-3199'),
    # (3,'Federal Shipping','(503) 555-9931');

    # You might need to configure max_allowed_packet, if you are inserting huge datasets

    redirect_to companies_bulk_create_form_path,
                notice: "Created companies with the following ids: #{company_ids.pluck("id")}"
    # the company_ids is only valid for psql and sqlite
  end

  def bulk_update_form
    @companies = Company.all
  end

  def bulk_update
    # if the updated values is the same for all companies you can use: `update_all`

    # NOTE: this method is only available in Rails 6
    # and will do an update if ID is found, otherwise it will do a create/INSERT
    Company.upsert_all(params[:companies_to_update])
    redirect_to companies_bulk_update_form_path, notice: "Updated companies"
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:name)
  end
end
