class ContactsController < ApplicationController

  def index
    if params[:search]
      @people = Contact.where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?",
        "%#{params[:search]}%", 
        "%#{params[:search]}%", 
        "%#{params[:search]}%"
        )
    elsif current_user
      @people = Contact.where("user_id LIKE ?", "#{current_user.id}")
    else
      redirect_to '/users/sign_in'
    end
  end

  def new
    unless current_user
      redirect_to '/users/sign_in'
    end
  end

  def create 
  @new_contact = Contact.create(
    first_name: params[:input_first_name],
    last_name: params[:input_last_name],
    phone_number: params[:input_phone_number],
    email: params[:input_email],
    user_id: current_user.id 
    )

    flash[:success] = "Contact created!"
    redirect_to '/contacts'
  end

  def show
    if current_user
      @person = Contact.find_by(id: params[:id])
    else
      redirect_to'/users/sign_in'
    end
  end

  def edit
    @edited_contact = Contact.find_by(id: params[:id])
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.update(
      first_name: params[:input_first_name],
      last_name: params[:input_last_name],
      phone_number: params[:input_phone_number],
      email: params[:input_email]
      )
    redirect_to '/contacts'
  end

  def destroy
    contact_to_delete = Contact.find_by(id: params[:id])
    contact_to_delete.destroy
    redirect_to '/contacts'
  end

end
