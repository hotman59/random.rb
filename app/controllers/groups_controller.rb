class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :clearteam]
  before_action :set_personne, only: [:update_sensei]
  before_action :minim_group, only: [:random_people]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @people = Person.all
  end

def update_sensei
  parse = @person.sensei
  if parse
    @person.sensei = false
  else
    @person.sensei = true
end
@person.save

redirect_to :root
end


def clearteam
  team = Person.all
  team.each do |person|
  if person.group_id == @group.id
    person.group_id = nil
    person.save
  end
end
redirect_to :root
end

#algo random
  # def random_people
  #   @groups = Group.all
  #   @people = Person.all
  #
  #   my_max_group = (@people.size / @groups.size).ceil + 1
  #   id_group = []
  #
  #   @people.each do |p|
  #     p.group_id = 0
  #     p.sensei = false
  #     p.save
  #   end
  #
  #   @groups.each do |group|
  #     id_group << group.id
  #   end
  #
  #   @people.each do |i|
  #     random_group = id_group.sample
  #     i.group_id = random_group
  #       i.save
  #     if @people.where(group_id: random_group).size == my_max_group
  #       id_group.delete(random_group)
  #     end
  # end
  # redirect_to root_path

def random_people
   idperson = Person.all.map{|x| x.id}
   Person.all.each do |p|
      p.group_id = 0
      p.sensei = false
      p.save
   end
   if Group.all.count>0
     while idperson.count >0
       Group.all.each do |grp|
         a = idperson.sample
         Person.find(a).update_attributes(group_id: grp.id) unless a.nil?
         ## summarize that:
         # b = Person.find(a)
         # b.group_id = grp.id
         # b.save
         idperson.delete(a)
       end
     end
     redirect_to :root, notice: "Yataî  all has been randomized!!!"

     else
       redirect_to :root, notice: "ther have to be a least one group"
     end

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
      team = Person.all
      team.each do |person|
      if person.group_id == @group.id
        person.group_id = nil
        person.save
      end
    end
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
    def set_personne
      @person = Person.find(params[:id])
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
