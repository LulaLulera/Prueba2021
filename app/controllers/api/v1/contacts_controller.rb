module Api
	module V1
		class ContactsController < ApplicationController
			def index
				contacts = Contact.all

				render json: ContactSerializer.new(contacts).serialized_json
			end

			def show
				contact = Contact.find_by(name: params[:name])

				render json: ContactSerializer.new(contact).serialized_json
			end

			def create
				contact = Contact.new(contact_params)

				if contact.save
					render json: ContactSerializer.new(contact).serialized_json
				else
					render json: {error: contact.error.messages}, status: 422
				end
			end

			def update
				contact = Contact.find_by(name: params[:name])

				if contact.update(contact_params)
					render json: ContactSerializer.new(contact).serialized_json
				else
					render json: {error: contact.error.messages}, status: 422
				end
			end

			def destroy
				contact = Contact.find_by(name: params[:name])

				if contact.destroy
					head :no_content
				else
					render json: {error: contact.error.messages}, status: 422
				end
			end

			private
			def contact_params
				params.require(:contact).oermnit(:name, :last_name, :email, :phone_number)
			end
		end
	end
end