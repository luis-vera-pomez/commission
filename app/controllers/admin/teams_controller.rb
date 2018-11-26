class Admin::TeamsController < Admin::BaseController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :generate_supervisors, :simulate_sales]

  def index
    authorize! :index, Team
    
    @datatable = TeamsDatatable.new(self)
  end

  def show
    @agents = AgentsDatatable.new(self, team_id: @team.id)
    @sales = SalesDatatable.new(self, team_id: @team.id)
  end

  def new
    @team = Team.new
  end

  def edit
    @agents = AgentsDatatable.new(self, team_id: @team.id)
    @sales = SalesDatatable.new(self, team_id: @team.id)
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to admin_team_path(@team), notice: 'team was successfully created.'
    else
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to admin_team_path(@team), notice: 'team was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'team was successfully destroyed.'
  end

  def generate_supervisors
    quantity = params[:quantity]
    gender = params[:gender]
    role = params[:role].to_sym
    message = ''

    Team.transaction do
      begin
        user_interface = UserInterface.new(team: @team, quantity: quantity, role: role, gender: gender)
        user_interface.generate_users

        return redirect_to admin_team_path(@team), notice: "#{quantity} #{gender} supervisors where successfully included in the team."
      rescue => e
        message = "Error generating supervisors. Details: #{e.message}"
        @agents = AgentsDatatable.new(self, team_id: @team.id)
        @sales = SalesDatatable.new(self, team_id: @team.id)
        raise ActiveRecord::Rollback
      end
    end

    render :edit, notice: message
  end

  def simulate_sales
    quantity = params[:quantity]

    Team.transaction do
      begin
        @team.agents.seller.limit(quantity).each do |agent|
          number = rand(4)
          array = (1..number).map { |n| rand(1..4) }.uniq

          Product.where(id: array).each do |product|
            product_quantity = rand(1..10)
            total = product_quantity * product.price
            saled_at = Time.zone.now - (rand(150)).days

            Sale.create!(product: product, agent: agent, quantity: product_quantity, total: total, saled_at: saled_at)
          end
        end

        return redirect_to admin_team_path(@team), notice: "Sales for #{quantity} agents where successfully simulated."
      rescue => e
        message = "Error simulating sales. Details: #{e.message}"
        @agents = AgentsDatatable.new(self, team_id: @team.id)
        @sales = SalesDatatable.new(self, team_id: @team.id)
        raise ActiveRecord::Rollback
      end
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:title, :description, :location)
    end
end
