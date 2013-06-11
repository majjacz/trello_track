class TimeRecordsController < ApplicationController
  before_action :set_time_record, only: [:stop, :pause, :continue_from_pause, :edit, :update, :destroy]

  def edit
  end

  def stop
  end

  def pause
  end

  def continue_from_pause
  end

  def create
    @time_record = TimeRecord.new(time_record_params)

    respond_to do |format|
      if @time_record.save
        format.html { redirect_to @time_record, notice: 'Time record was successfully created.' }
        format.json { render action: 'show', status: :created, location: @time_record }
      else
        format.html { render action: 'new' }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_records/1
  # PATCH/PUT /time_records/1.json
  def update
    respond_to do |format|
      if @time_record.update(time_record_params)
        format.html { redirect_to root_path, notice: 'Time record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_records/1
  # DELETE /time_records/1.json
  def destroy
    @time_record.destroy
    respond_to do |format|
      format.html { redirect_to time_records_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_record
      @time_record = TimeRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_record_params
      params.require(:time_record).permit(:user_id, :name, :trello_board_id, :trello_card_id, :start_time, :end_time, :paused_for, :paused )
    end
end
