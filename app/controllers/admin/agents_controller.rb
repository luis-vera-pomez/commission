class Admin::AgentsController < Admin::BaseController
  before_action :set_agent, only: [:show, :edit, :update, :destroy, :generate_agents]
  before_action :set_team, only: [:new, :create]

  def index
    authorize! :index, Agent
    
    @datatable = AgentsDatatable.new(self)
  end

  def show
    @dependants = DependantAgentsDatatable.new(self, team_id: @agent.team.id, supervised_by_id: @agent.id)
  end

  def new
    @agent = Agent.new
  end

  def edit
    @dependants = DependantAgentsDatatable.new(self, team_id: @agent.team.id, supervised_by_id: @agent.id)
    @sales = AgentSalesDatatable.new(self, agent_id: @agent.id)
  end

  def create
    @agent = @team.agents.build
    @agent.assign_attributes(agent_params)

    if @agent.save
      redirect_to admin_team_agent_path(@agent.team, @agent), notice: 'Agent was successfully created.'
    else
      render :new
    end
  end

  def update
    if @agent.update(agent_params)
      redirect_to admin_team_agent_path(@agent.team, @agent), notice: 'Agent was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @agent.destroy
    redirect_to agents_url, notice: 'Agent was successfully destroyed.'
  end

  def generate_agents
    quantity = params[:quantity]
    gender = params[:gender]
    role = params[:role].to_sym
    message = ''

    Team.transaction do
      begin
        user_interface = UserInterface.new(team: @agent.team, quantity: quantity, role: role, gender: gender, supervised_by: @agent)
        user_interface.generate_users

        return redirect_to admin_team_agent_path(@agent.team, @agent), notice: "#{quantity} #{gender} agents where successfully associated to the supervisor."
      rescue => e
        message = "Error generating agents. Details: #{e.message}"
        raise ActiveRecord::Rollback
      end
    end

    render :edit, notice: message
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end

    def set_agent
      @agent = Agent.find(params[:id])
    end

    def agent_params
      params.require(:agent).permit(:user_id, :associated_at, :departed_at, :supervised_by_id)
    end
end
