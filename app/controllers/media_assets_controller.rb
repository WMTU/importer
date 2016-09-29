class MediaAssetsController < ApplicationController
  before_action :set_media_asset, only: [:show, :edit, :update, :destroy]

  # GET /media_assets
  # GET /media_assets.json
  def index
    @media_assets = MediaAsset.all
  end

  # GET /media_assets/1
  # GET /media_assets/1.json
  def show
  end

  # GET /media_assets/new
  def new
    @media_asset = MediaAsset.new
  end

  # GET /media_assets/1/edit
  def edit
  end

  # POST /media_assets
  # POST /media_assets.json
  def create
    @media_asset = MediaAsset.new(audio_file: params[:file])

    if @media_asset.save
			respond_to do |format|
        format.json { render json: @media_asset }
      end
    end
  end

  # PATCH/PUT /media_assets/1
  # PATCH/PUT /media_assets/1.json
  def update
    respond_to do |format|
      if @media_asset.update(media_asset_params)
        format.html { redirect_to @media_asset, notice: 'Media asset was successfully updated.' }
        format.json { render :show, status: :ok, location: @media_asset }
      else
        format.html { render :edit }
        format.json { render json: @media_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_assets/1
  # DELETE /media_assets/1.json
  def destroy
    @media_asset.destroy
    respond_to do |format|
      format.html { redirect_to media_assets_url, notice: 'Media asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_asset
      @media_asset = MediaAsset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def media_asset_params
      params.require(:media_asset).permit(:title, :artist, :album, :year, :channels, :sample_rate, :cue, :intro, :eom, :audio_file)
    end
end
