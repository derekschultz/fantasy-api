class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show update destroy ]

  # GET /players
  def index
    @players = Player.all

    render json: @players.to_json(:except => [:full_name, :sport, :created_at, :updated_at])
  end

  # GET /players/1
  def show
    @player = Player.find(params[:id])
    render json: @player
  end

  def search
    @result = Player.search(params)
    render json: @result.to_json(:except => [:full_name, :sport, :created_at, :updated_at])
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:first_letter_of_last_name, :age, :min_age, :max_age, :position, :sport)
    end
end
