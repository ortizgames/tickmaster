class TickTracksController < ApplicationController
  # GET /tick_tracks
  # GET /tick_tracks.json
  def index
    @tick_tracks = TickTrack.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tick_tracks }
    end
  end

  # GET /tick_tracks/1
  # GET /tick_tracks/1.json
  def show
    @tick_track = TickTrack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tick_track }
    end
  end

  # GET /tick_tracks/new
  # GET /tick_tracks/new.json
  def new
    @tick_track = TickTrack.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tick_track }
    end
  end

  # GET /tick_tracks/1/edit
  def edit
    @tick_track = TickTrack.find(params[:id])
  end

  # POST /tick_tracks
  # POST /tick_tracks.json
  def create
    @tick_track = TickTrack.new(params[:tick_track])
    if @tick_track.bulkCount != nil
      if @tick_track.bulkCount > 1
        labelAdd = 1
        @tick_track.name = @tick_track.name + " " + labelAdd.to_s
        saveSuccess = @tick_track.save
        until (labelAdd - 1) == @tick_track.bulkCount
          labelAdd += 1
          @tick_track = TickTrack.new(params[:tick_track])
          @tick_track.name = @tick_track.name + " " + labelAdd.to_s
          saveSuccess = @tick_track.save
        end
      else
        saveSuccess = @tick_track.save
      end
    else
      saveSuccess = @tick_track.save
    end

    respond_to do |format|
      if saveSuccess
        format.html { redirect_to tick_tracks_url }
        format.json { render json: @tick_track, status: :created, location: @tick_track }
      else
        format.html { render action: "new" }
        format.json { render json: @tick_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tick_tracks/1
  # PUT /tick_tracks/1.json
  def update
    @tick_track = TickTrack.find(params[:id])

    respond_to do |format|
      if @tick_track.update_attributes(params[:tick_track])
        format.html { redirect_to tick_tracks_url }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tick_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tick_tracks/1
  # DELETE /tick_tracks/1.json
  def destroy
    @tick_track = TickTrack.find(params[:id])
    @tick_track.destroy

    respond_to do |format|
      format.html { redirect_to tick_tracks_url }
      format.json { head :no_content }
    end
  end

  #PUT /tick_tracks/1/incTick?amount=X
  def incTick
    @tick_track = TickTrack.find(params[:id])
    if params[:amount] != nil
      @tick_track.tick += params[:amount].to_i
      @tick_track.save
    end

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  #POST /decAll
  def decAll
    @tick_tracks = TickTrack.all
    @tick_tracks.each do |tick_track|
      tick_track.decrement(:tick) if tick_track.tick > 0
      tick_track.tick = 0 if tick_track.tick < 0
      tick_track.save
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  #PUT /tick_tracks/1/incWound?amount=X
  def incWound
    @tick_track = TickTrack.find(params[:id])
    if params[:amount] != nil
      @tick_track.wound += params[:amount].to_i
      @tick_track.save
    end

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  #PUT /tick_tracks/1/resetWound
  def resetWound
    @tick_track = TickTrack.find(params[:id])
    @tick_track.wound = 0
    @tick_track.save
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
end
