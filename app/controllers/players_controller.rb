class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  skip_before_filter :check_for_login, only: [:create, :new]

  # GET /players
  def index
    @players = Player.all
  end

  # GET /players/1
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  def create
    @player = Player.find_or_initialize_by(name: params[:player][:name])

    if @player.save
      session[:player] = @player.id
      redirect_to games_path, notice: "Logged in as: #{@player.name}."
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
    redirect_to players_url, notice: 'Player was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name)
    end
end
