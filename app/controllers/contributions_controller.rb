class ContributionsController < ApplicationController
  before_filter :get_contribution, :only => 
    [:show, :edit, :update, :destroy, :vote_argumentative_weight, :vote_style]
  
  # GET /contributions
  # GET /contributions.xml
  def index
    @contributions = Contribution.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contributions }
    end
  end

  # GET /contributions/1
  # GET /contributions/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contribution }
    end
  end

  # GET /contributions/new
  # GET /contributions/new.xml
  def new
    @contribution = Contribution.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contribution }
    end
  end

  # GET /contributions/1/edit
  def edit
  end

  # POST /contributions
  # POST /contributions.xml
  def create
    @contribution = Contribution.new(params[:contribution])

    respond_to do |format|
      if @contribution.save
        flash[:notice] = 'Contribution was successfully created.'
        format.html { redirect_to(@contribution) }
        format.xml  { render :xml => @contribution, :status => :created, :location => @contribution }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contribution.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contributions/1
  # PUT /contributions/1.xml
  def update
    respond_to do |format|
      if @contribution.update_attributes(params[:contribution])
        flash[:notice] = 'Contribution was successfully updated.'
        format.html { redirect_to(@contribution) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contribution.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.xml
  def destroy
    @contribution.destroy

    respond_to do |format|
      format.html { redirect_to(contributions_url) }
      format.xml  { head :ok }
    end
  end
  
  def vote_argumentative_weight
    @user = User.find_by_name('John Doe')
    
    val = params[:value].to_f
    if not (-1..1).include? val
      flash[:notice] = 'Voting value out of range.'
      redirect_to :action => 'show', :params => { :id => @contribution.root.id }
      return
    end
    @contribution.ratings.create \
      :type_id => ContributionRating.types.index(:argumentative_weight),
      :value => val,
      :user => @user
    
    flash[:notice] = 'Vote accepted.'
    redirect_to :action => 'show', :params => { :id => @contribution.root.id }
  end
  
  def vote_style
    
  end
  
private
  
  def get_contribution
    @contribution = Contribution.find(params[:id])
  end
end
