class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :minim_group, only: [:random_people]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @people = Person.all
  end

#algo random
  def random_people
    @groups = Group.all
    @people = Person.all
    my_max_group = (@people.size / @groups.size).ceil + 1
    id_group = []

    @people.each do |p|
      p.group_id = 0
      p.save
    end

    @groups.each do |group|
      id_group << group.id
    end

    @people.each do |i|
      random_group = id_group.sample
      i.group_id = random_group
        i.save
      if @people.where(group_id: random_group).size == my_max_group
        id_group.delete(random_group)
      end
  end
  redirect_to root_path

  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to root_path, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

def minim_group
if Group.all.size < 2
  redirect_to root_path, notice: "il manque le nombre de groupe"
end
end
    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name_group, :salle, :tache)
    end
    def person_params
    params.require(:person).permit(:name, :group_id, :sensei)
  end
end
