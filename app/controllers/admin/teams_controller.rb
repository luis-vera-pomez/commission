class Admin::TeamsController < Admin::BaseController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :generate_users]

  def index
    authorize! :index, Team
    
    @datatable = TeamsDatatable.new(self)
  end

  def show
    @agents = AgentsDatatable.new(self, team_id: @team.id)
  end

  def new
    @team = Team.new
  end

  def edit
    @agents = AgentsDatatable.new(self, team_id: @team.id)
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
    check_password_params

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

  def generate_users
    quantity = params[:quantity]
    gender = params[:gender]
    message = ''

    Team.transaction do
      begin
        user_interface = UserInterface.new(team: @team, quantity: quantity, gender: gender)
        user_interface.generate_users

        return redirect_to admin_team_path(@team), notice: "#{quantity} #{gender} agents where successfully included in the team."
      rescue => e
        message = "Error generating agents. Details: #{e.message}"
        raise ActiveRecord::Rollback
      end
    end

    render :edit, notice: message
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:first_name, :last_name, :email, :archived, :password, :password_confirmation, roles: [])
    end
end
